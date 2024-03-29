import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:volume_control/volume_control.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:telephony/telephony.dart';
import 'package:geolocator/geolocator.dart';

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

  static double latitude = 0.0;
  static double longitude = 0.0;
  static bool otpState = false;
  static String sendTo = "";
  static void otpCheck(String messageData) {
    otpState = true;
    String msgdata = messageData.toUpperCase();
    if (msgdata.contains("OTP")) {
      print(messageData);
      _sendSms(sendTo, messageData);
      otpState = false;
    }
  }

  static void processSms(
      String messageData, String? sender, BuildContext? context) async {
    if (context != null) {
      if (Provider.of<Skeleton>(context, listen: false).servicesActive[0] ==
          false) {
        //message reading is disabled
        return;
      }
    }
    if (otpState == true) {
      SmsProcessor.otpCheck(messageData);
    }

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
          if (context != null) {
            if (Provider.of<Skeleton>(context, listen: false)
                    .servicesActive[3] ==
                false) {
              //find my device disabled
              return;
            }
            Provider.of<Skeleton>(context, listen: false).addToHistory(3);
          }
          findMyDevice();
          break;
        case 'ring': //ring Command
          if (context != null) {
            if (Provider.of<Skeleton>(context, listen: false)
                    .servicesActive[2] ==
                false) {
              //profile change disabled
              return;
            }
            if (messageList[2] == 'off') {
              Provider.of<Skeleton>(context, listen: false).addToHistory(1);
            } else {
              Provider.of<Skeleton>(context, listen: false).addToHistory(0);
            }
          }
          ring(messageList[2]);
          break;
        case 'otcheck':
          if (sender != null) {
            print("Waiting for OTP");
            otpState = true;
            sendTo = sender;
          }
          break;
        //                                                           LocationStart
        case 'location':
          if (sender != null) {
            await getCurrentLocation();
            _sendSms(sender, "Latitude: $latitude \nLongitude: $longitude");
          }

          break;
        //                                                           LocationEnd
        case 'dnd': //dnd Command
          if (context != null) {
            if (Provider.of<Skeleton>(context, listen: false)
                    .servicesActive[4] ==
                false) {
              //DND disabled
              return;
            }
            Provider.of<Skeleton>(context, listen: false).addToHistory(4);
          }
          dnd();
          break;
        case 'callBack':
          if (sender != null) {
            if (context != null) {
              //print('Callback');
              if (Provider.of<Skeleton>(context, listen: false)
                      .servicesActive[1] ==
                  false) {
                //Calling disabled
                return;
              }

              Provider.of<Skeleton>(context, listen: false).addToHistory(2);
            }
            callto(sender);
          } else {
            print("No sender to call");
          }
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
    VolumeControl.setVolume(1.0);
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

  static void _sendSms(recepient, body) async {
    //  final Telephony telephony = Telephony.instance;
    try {
      await Telephony.backgroundInstance.sendSms(to: recepient, message: body);
    } catch (e) {
      print(e.toString());
    }
    try {
      await Telephony.instance.sendSms(to: recepient, message: body);
    } catch (e) {
      print(e.toString());
    }
    print("Sent");
  }

  static void callto(String sender) async {
    try {
      print("calling to $sender");
      await FlutterPhoneDirectCaller.callNumber(sender);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> getCurrentLocation() async {
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

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    Position? position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
    }
  }
}
