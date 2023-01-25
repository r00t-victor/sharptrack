import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sharptrack/widgets/historytile.dart';
import 'package:sharptrack/widgets/servicescard.dart';

class HomePageContent extends StatelessWidget {
  HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<Skeleton>(builder: ((context, value, child) {
            return Text(
              'Hi ${value.name}!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            );
          })),
          const SizedBox(
            height: 20.0,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(
              Provider.of<Skeleton>(context).servicesLabels.length,
              ((index) {
                return ServicesCard(index: index);
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
            child: Consumer<Skeleton>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.historyCount,
                  itemBuilder: ((context, index) {
                    return HistoryTile(
                      tileIcon: value.getHistoryIcon(index),
                      tileTitle: value.getHistoryTitle(index),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
