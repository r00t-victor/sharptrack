import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isVisiblePin = true;
  bool isVisibleName = false;
  bool isVisiblePass = false;
  final TextEditingController control0 = TextEditingController();
  final TextEditingController control1 = TextEditingController();
  final TextEditingController control2 = TextEditingController();
  final TextEditingController control3 = TextEditingController();
  final TextEditingController control4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isVisiblePin = !isVisiblePin;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 36, 45, 49),
                foregroundColor: Color.fromARGB(255, 238, 241, 242),
                alignment: Alignment.center,
                minimumSize: Size(150.0, 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Pin Change'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isVisiblePin,
              child: TextField(
                obscureText: true,
                maxLength: 4,
                controller: control0,
                decoration: const InputDecoration(labelText: "Enter Pin"),
              ),
            ),
            Visibility(
              visible: isVisiblePin,
              child: TextField(
                obscureText: true,
                maxLength: 4,
                controller: control1,
                decoration: const InputDecoration(labelText: "Confirm Pin"),
              ),
            ),
            Visibility(
              visible: isVisiblePin,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  if (control0.text == control1.text) {
                    pre.setString("#Pin", control0.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved PIN')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PIN not same')));
                  }
                  control0.clear();
                  control1.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('  SAVE  '),
              ),
            ),
            Visibility(
              visible: isVisiblePin,
              child: const SizedBox(
                height: 40.0,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isVisibleName = !isVisibleName;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 36, 45, 49),
                foregroundColor: Color.fromARGB(255, 238, 241, 242),
                alignment: Alignment.center,
                minimumSize: Size(150.0, 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Name Change'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isVisibleName,
              child: TextField(
                maxLength: 20,
                controller: control2,
                decoration: const InputDecoration(labelText: "Enter Name"),
              ),
            ),
            Visibility(
              visible: isVisibleName,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  pre.setString("#Name", control2.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved Name')));
                  control2.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('  SAVE  '),
              ),
            ),
            Visibility(
              visible: isVisibleName,
              child: const SizedBox(
                height: 40.0,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isVisiblePass = !isVisiblePass;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 36, 45, 49),
                foregroundColor: Color.fromARGB(255, 238, 241, 242),
                alignment: Alignment.center,
                minimumSize: Size(150.0, 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Password Change'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isVisiblePass,
              child: TextField(
                obscureText: true,
                maxLength: 10,
                controller: control3,
                decoration: const InputDecoration(labelText: "Enter Password"),
              ),
            ),
            Visibility(
              visible: isVisiblePass,
              child: TextField(
                obscureText: true,
                maxLength: 10,
                controller: control4,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
              ),
            ),
            Visibility(
              visible: isVisiblePass,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  if (control3.text == control4.text) {
                    pre.setString("#Pass", control0.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved Password')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password not same')));
                  }
                  control3.clear();
                  control4.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('  SAVE  '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
