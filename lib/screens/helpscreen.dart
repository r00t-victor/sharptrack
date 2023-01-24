import 'package:flutter/material.dart';

class Helpscreen extends StatelessWidget {
  const Helpscreen({super.key});

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
              children: const [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN callBack",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          "Call back to the number from which command is received",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN dnd",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Put the device in Do Not Disturb mode",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN location",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          "Sends the location of device to the number from which command is received",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN ring",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Switch the device to general profile",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN ring off",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Switch the device to Vibration profile",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "#PIN findMyDevice",
                        textScaleFactor: 1.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Let the device ring to find the device",
                          textScaleFactor: 1.2),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
