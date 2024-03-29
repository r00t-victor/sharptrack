import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharptrack/skeleton.dart';
import 'welcomescreen.dart';
import 'lockscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.repeat();
    _navigateToHome();
  }

  void _navigateToHome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? loggedin = pref.getBool('loggedin');
    // loggedin = true;
    if (loggedin != null && loggedin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Provider.of<Skeleton>(context, listen: false).loggedin
                    ? HomePage()
                    : LockScreen()),
      );
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 150,
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
