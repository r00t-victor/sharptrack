import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'smsprocessor.dart';
import 'package:telephony/telephony.dart';

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

  List<bool> servicesActive = [false, true, true, true, true];

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

  void toggleServices(int index, BuildContext context) {
    print("Toggling ${servicesLabels[index]}");
    servicesActive[index] = !servicesActive[index];
    if (servicesActive[index]) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${servicesLabels[index]} enabled!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${servicesLabels[index]} disabled!')));
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
