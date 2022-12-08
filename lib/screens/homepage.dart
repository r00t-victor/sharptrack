import 'package:flutter/material.dart';
import 'package:sharptrack/widgets/historytile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text('#Track'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'S',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, top: 30, bottom: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi Saurabh!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.0,
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sms),
                      Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call),
                      Text(
                        'Calls',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.vibration),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.music_note),
                      Text(
                        'Find My Device',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.do_not_disturb),
                      Text(
                        'Do Not Disturb',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '#History',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: ((context, index) {
                  return HistoryTile(index: index);
                }),
              ),
            ),
            // Text('See more...'),
          ],
        ),
      ),
    );
  }
}
