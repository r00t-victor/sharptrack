import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:telephony/telephony.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isVisiblePin = false;
  bool isVisibleName = false;
  bool isVisiblePass = false;
  final Telephony telephony = Telephony.instance;
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
                  isVisiblePass = false;
                  isVisibleName = false;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 36, 45, 49),
                foregroundColor: Color.fromARGB(255, 238, 241, 242),
                alignment: Alignment.center,
                minimumSize: Size(180.0, 35.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Pin Change'),
            ),
            Visibility(
              visible: isVisiblePin,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    obscureText: true,
                    maxLength: 4,
                    controller: control0,
                    decoration: const InputDecoration(labelText: "Enter Pin"),
                  ),
                  TextField(
                    obscureText: true,
                    maxLength: 4,
                    controller: control1,
                    decoration: const InputDecoration(labelText: "Confirm Pin"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences pre =
                          await SharedPreferences.getInstance();
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
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isVisibleName = !isVisibleName;
                      isVisiblePass = false;
                      isVisiblePin = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 36, 45, 49),
                    foregroundColor: Color.fromARGB(255, 238, 241, 242),
                    alignment: Alignment.center,
                    minimumSize: Size(180.0, 35.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Name Change'),
                ),
                Visibility(
                  visible: isVisibleName,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        maxLength: 20,
                        controller: control2,
                        decoration:
                            const InputDecoration(labelText: "Enter Name"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (control2.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Name Field Empty')));
                          } else {
                            Provider.of<Skeleton>(context, listen: false)
                                .setName = control2.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved Name')));
                          }
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
                      const SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isVisiblePass = !isVisiblePass;
                      isVisiblePin = false;
                      isVisibleName = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 36, 45, 49),
                    foregroundColor: const Color.fromARGB(255, 238, 241, 242),
                    alignment: Alignment.center,
                    minimumSize: const Size(180.0, 35.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Password Change'),
                ),
                Visibility(
                  visible: isVisiblePass,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        obscureText: true,
                        maxLength: 10,
                        controller: control3,
                        decoration:
                            const InputDecoration(labelText: "Enter Password"),
                      ),
                      TextField(
                        obscureText: true,
                        maxLength: 10,
                        controller: control4,
                        decoration: const InputDecoration(
                            labelText: "Confirm Password"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pre =
                              await SharedPreferences.getInstance();
                          if (control3.text == control4.text) {
                            pre.setString("#Pass", control3.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Saved Password')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Password not same')));
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
