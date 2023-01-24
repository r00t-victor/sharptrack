import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:volume_control/volume_control.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
          //
          //
          //
          //print('playing audio');
          findMyDevice();
          break;
        case 'ring': //ring Command
          ring(messageList[2]);
          break;
        case 'dnd': //dnd Command
          dnd();
          break;
        case 'callBack':
          //print('Callback');
          callto();
          break;
        default:
          print(messageList[1]);
      }
    } else {
      print('wrong password');
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

  static void ring(String option) async {
    try {
      if (option == 'off') {
        await SoundMode.setSoundMode(RingerModeStatus.vibrate);
      } else {
        await SoundMode.setSoundMode(RingerModeStatus.normal);
      }
    } on PlatformException {
      print('Please enable permissions required');
    }
  }

  static void dnd() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    } on PlatformException {
      print('Please enable permissions required');
    }
  }

  static void callto() async {
    try {
      await FlutterPhoneDirectCaller.callNumber('8933884033');
    } catch (e) {
      print(e.toString());
    }
  }
}
