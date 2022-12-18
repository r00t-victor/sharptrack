import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_control/volume_control.dart';

class SmsProcessor {
  static Future<bool> verifyPin(String pass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var appPin = pref.getString('#Pin') ?? '';
    //print('verifying pin $appPin');
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
      switch (messageList[1]) {
        case 'findMyDevice':
          print('playing audio');
          findMyDevice();
          break;
        default:
          print(messageList[1]);
      }
    } else {
      print('wrong pass');
    }
  }

  static void findMyDevice() async {
    final player = AudioPlayer();
    await player.setSource(AssetSource('ring.mp3'));
    //volume control
    double val = await VolumeControl.volume;
    // Set the new volume value, between 0-1
    VolumeControl.setVolume(0.8);
    await player.resume();
    await Future.delayed(const Duration(seconds: 10));
    player.stop();

    VolumeControl.setVolume(val);
  }
}
