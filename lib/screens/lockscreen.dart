import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharptrack/screens/homepage.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _savedPin = '';

  @override
  void initState() {
    super.initState();
    _loadSavedPin();
  }

  void _loadSavedPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPin = prefs.getString('#Pass') ?? '';
    });
  }

  void _checkPin() {
    if (_formKey.currentState!.validate()) {
      if (_pinController.text == _savedPin) {
        // Correct PIN, navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Incorrect PIN, show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid password'),
              content: Text('Please enter the correct password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FlutterLogo(
              //   size: 150,
              // ),
              Icon(Icons.lock),
              SizedBox(height: 20),
              Text(
                'Enter Password',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkPin,
                child: Text('Unlock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
