import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/screens/homepage.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sharptrack/smsprocessor.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Skeleton(), child: const MyApp()));
}

//Static function for backround running
backgroundMessageHandler(SmsMessage message) async {
  String? text = message.body;
  if (text != null) {
    SmsProcessor.processSms(text);
  }
  // debugPrint(message.body);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void checkandlisten() async {
    bool? permissionsGranted =
        await Telephony.instance.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      debugPrint('Permission granted');
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
        listenInBackground: false,
        //onBackgroundMessage: backgroundMessageHandler,
      );
    } else {
      print('permission not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    checkandlisten();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.black, centerTitle: true),
      ),
      title: '#Track',
      home: HomePage(),
    );
  }
}
