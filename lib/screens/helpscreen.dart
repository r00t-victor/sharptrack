import 'package:flutter/material.dart';

class Helpscreen extends StatelessWidget {
  Helpscreen({super.key});

  final commandsMap = {
    "#PIN callBack": "Call back to the number from which command is received",
    "#PIN dnd": "Put the device in Do Not Disturb mode",
    "#PIN ring on": "Switch the device to general profile",
    "#PIN ring off": "Switch the device to Vibration profile",
    "#PIN findMyDevice": "Let the device play music to find the device"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('Help'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [
          const Text(
            'Command List',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Table(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: commandsMap.entries.map((e) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        e.key,
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(e.value, textScaleFactor: 1.2),
                    ),
                  ],
                );
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}
