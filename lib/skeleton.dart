import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'smsprocessor.dart';
import 'package:telephony/telephony.dart';
import 'package:geolocator/geolocator.dart';

BuildContext? appContext;
//Static function for backround running
@pragma('vm:entry-point')
backgroundMessageHandler(SmsMessage message) async {
  String? text = message.body;
  if (text != null) {
    SmsProcessor.processSms(text, message.address, null);
  }
  // debugPrint(message.body);
}

@pragma('vm:entry-point')
void startTelephony(BuildContext context) {
  appContext = context;
  Telephony.instance.listenIncomingSms(
    onNewMessage: (SmsMessage message) {
      // print('New message');
      // print(message.address);
      // print(message.body);
      String? text = message.body;
      String? sender = message.address;
      if (text != null) {
        SmsProcessor.processSms(text, sender, context);
      }
    },
    listenInBackground: true,
    onBackgroundMessage: backgroundMessageHandler,
  );
}

class Skeleton extends ChangeNotifier {
  String? _name;
  bool _loggedin = false;

  final List<String> servicesLabels = [
    'Messages',
    'Calls',
    'Profiles',
    'Find My Device',
    'Do Not Disturb'
  ];
  final List<IconData> servicesIcons = [
    Icons.sms,
    Icons.call,
    Icons.vibration,
    Icons.music_note,
    Icons.do_not_disturb
  ];

  List<bool> servicesActive = [false, false, false, false, false];

  List<String> functionsForHistory = [
    'Ring on',
    'vibrate',
    'Callback',
    'Find My Device',
    'Do not Disturb'
  ];

  List<IconData> iconsForHistory = [
    Icons.ring_volume,
    Icons.vibration,
    Icons.call,
    Icons.music_note,
    Icons.do_not_disturb
  ];

  List<int> history = [];

  void loadServicesActiveStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? l = prefs.getString('servicesActive');
    if (l != null) {
      int index = 1;
      l.runes.forEach((element) {
        servicesActive[index] = (element == 49); //ASCII val of 1
        index += 1;
      });
      notifyListeners();
    }
  }

  void toggleServices(int index, BuildContext context, bool v) {
    print("Toggling ${servicesLabels[index]}");
    servicesActive[index] = v;
    if (servicesActive[index]) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${servicesLabels[index]} enabled!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${servicesLabels[index]} disabled!')));
    }
    if (index > 0) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        String l = '';
        for (int i = 1; i < servicesActive.length; i++) {
          l += servicesActive[i] ? '1' : '0';
        }
        value.setString('servicesActive', l).then((value) {
          if (value)
            print('updated');
          else
            print('error update');
        });
      });
    }
    notifyListeners();
  }

  String get name {
    if (_name == null) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        _name = value.getString('#Name');
        notifyListeners();
      });
    }
    return _name ?? 'User';
  }

  set setName(String name) {
    _name = name;
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      value.setString('#Name', name);
      notifyListeners();
    });
  }

  bool get loggedin {
    return _loggedin;
  }

  set setloggedin(bool v) {
    _loggedin = v;
  }

  void enableBackgoundService(BuildContext context) async {
    bool? permissionsGranted =
        await Telephony.instance.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      debugPrint('Permission granted');
      servicesActive[0] = true;
      notifyListeners();
      startTelephony(context);
      loadHistory();
    } else {
      print('permission not available');
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }
    try {
      Geolocator.getCurrentPosition();
    } catch (e) {
      print(e.toString());
    }
  }

  void loadHistory() async {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      try {
        var h = jsonDecode(value.getString('history') ?? jsonEncode([]));
        history = [];
        for (final a in h) {
          history.add(a);
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
    });
  }

  void addToHistory(int index) async {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      try {
        List<int> h = [
          ...jsonDecode(value.getString('history') ?? jsonEncode([]))
        ];
        if (h.length > 4) {
          h.removeAt(0);
        }
        h.add(index);
        history = [];
        for (final a in h) {
          history.add(a);
        }
        value.setString('history', jsonEncode(history));
        notifyListeners();
      } catch (e) {
        print(e);
      }
    });
  }

  int get historyCount {
    return history.length;
  }

  IconData getHistoryIcon(index) {
    return iconsForHistory[history[index]];
  }

  String getHistoryTitle(index) {
    return functionsForHistory[history[index]];
  }
}
