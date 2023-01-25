import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  HistoryTile({super.key, required this.tileIcon, required this.tileTitle});
  final IconData tileIcon;
  final String tileTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(tileIcon),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tileTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                // Text(
                //   tileTimes[index],
                //   style: const TextStyle(color: Colors.black54),
                // ),
              ],
            )),
          ],
        ));
  }
}
