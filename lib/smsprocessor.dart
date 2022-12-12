import 'package:shared_preferences/shared_preferences.dart';

class SmsProcessor {
  static Future<bool> verifyPin(String pass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var appPin = pref.getString('#Pin') ?? '';
    if (appPin == pass.substring(1)) {
      return true;
    }
    return false;
  }

  static void processSms(String messageData) async {
    if (messageData[0] != '#') {
      print('Skipping message');
      return;
    }

    List<String> messageList = messageData.split(' ');
    if (messageList.length < 2) {
      //no command passed
      return;
    }
    if (await verifyPin(messageList[0])) {
      print(messageList[1]);
    } else {
      print('wrong pass');
    }
  }
}
