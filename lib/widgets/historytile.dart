import 'dart:ffi';

import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  HistoryTile({super.key, required this.index});
  final int index;
  final List<IconData> tileIcons = [
    Icons.location_on,
    Icons.sms,
    Icons.vibration,
    Icons.call_made,
    Icons.location_on,
    Icons.music_note,
    Icons.ring_volume
  ];
  final List<String> tileTitles = [
    'Access Location',
    'Send SMS',
    'Change Profile',
    'Call',
    'Access Location',
    'FInd My Device',
    'Change Profile'
  ];
  final List<String> tileTimes = [
    '3:04 PM',
    '2:59 PM',
    '1:02 PM',
    'yesterday',
    'yesterday',
    '6-11-22',
    '9-10-22'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(tileIcons[index]),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tileTitles[index]}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '${tileTimes[index]}',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            )),
          ],
        ));
  }
}
