import 'package:flutter/material.dart';
import 'package:sharptrack/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
