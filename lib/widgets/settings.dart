import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final TextEditingController control0 = TextEditingController();
  final TextEditingController control1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
      child: Column(
        children: [
          const Text(
            'Change Pin',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextField(
            obscureText: true,
            maxLength: 4,
            controller: control0,
            decoration: const InputDecoration(labelText: "Enter Pin"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            obscureText: true,
            maxLength: 4,
            controller: control1,
            decoration: const InputDecoration(labelText: "Confirm Pin"),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences pre = await SharedPreferences.getInstance();
              if (control0.text == control1.text) {
                pre.setString("#Pin", control0.text);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Saved PIN')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN not same')));
              }
              control0.clear();
              control1.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('  SAVE  '),
          ),
        ],
      ),
    );
  }
}
