import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/screens/splashscreen.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    enableBackgroundService();
  });
  runApp(ChangeNotifierProvider(
      create: (context) => Skeleton(), child: const MyApp()));
}

const notificationchannelId = 'sharptrach_id';
const notificationId = 8797;
@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // bring to foreground
  Timer.periodic(const Duration(seconds: 15), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          notificationId,
          'SharpTrack',
          'Sharptrack is running in background.',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationchannelId,
              'MY FOREGROUND SERVICE',
              icon: '@mipmap/ic_launcher',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}

void enableBackgroundService() async {
  print("enabling background");

  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationchannelId, // id
    'SharpTrack', // title
    description: 'Sharptrack is running in background.', // description
    importance: Importance.low,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId:
          notificationchannelId, // this must match with notification channel you created above.
      initialNotificationTitle: 'SharpTrack',
      initialNotificationContent: 'Sharptrack is running in background.',
      foregroundServiceNotificationId: notificationId,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.black, centerTitle: true),
      ),
      title: '#Track',
      home: SplashScreen(),
    );
  }
}
