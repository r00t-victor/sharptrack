import 'package:flutter/material.dart';
import 'package:sharptrack/widgets/historytile.dart';
import 'package:sharptrack/widgets/servicescard.dart';

class HomePageContent extends StatelessWidget {
  HomePageContent({super.key});
  final List<String> servicesLabels = [
    'Messages',
    'Location',
    'Calls',
    'Profiles',
    'Find My Device',
    'Do Not Disturb'
  ];
  final List<IconData> servicesIcons = [
    Icons.sms,
    Icons.location_on,
    Icons.call,
    Icons.vibration,
    Icons.music_note,
    Icons.do_not_disturb
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hi Saurabh!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20.0,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(
              servicesLabels.length,
              ((index) {
                return ServicesCard(
                    label: servicesLabels[index], icon: servicesIcons[index]);
              }),
            ),
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
    );
  }
}
