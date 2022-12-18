import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'smsprocessor.dart';
import 'package:telephony/telephony.dart';

//Static function for backround running
@pragma('vm:entry-point')
backgroundMessageHandler(SmsMessage message) async {
  String? text = message.body;
  if (text != null) {
    SmsProcessor.processSms(text);
  }
  // debugPrint(message.body);
}

@pragma('vm:entry-point')
void startTelephony() {
  Telephony.instance.listenIncomingSms(
    onNewMessage: (SmsMessage message) {
      // print('New message');
      // print(message.address);
      // print(message.body);
      String? text = message.body;
      if (text != null) {
        SmsProcessor.processSms(text);
      }
    },
    listenInBackground: true,
    onBackgroundMessage: backgroundMessageHandler,
  );
}

class Skeleton extends ChangeNotifier {
  String? _name;

  String get name {
    if (_name == null) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        _name = value.getString('name');
        notifyListeners();
      });
    }
    return _name ?? 'Saurabh';
  }

  set setName(String name) {
    _name = name;
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      value.setString('name', name);
      notifyListeners();
    });
  }

  void enableBackgoundService(BuildContext context) async {
    bool? permissionsGranted =
        await Telephony.instance.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      debugPrint('Permission granted');
      startTelephony();
    } else {
      print('permission not available');
    }
  }
}
