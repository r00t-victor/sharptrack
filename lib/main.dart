import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/screens/homepage.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:flutter_background/flutter_background.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Skeleton(), child: const MyApp()));
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
      home: HomePage(),
    );
  }
}
