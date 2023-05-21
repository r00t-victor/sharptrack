import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sharptrack/widgets/servicescard.dart';

class HomePageContent extends StatelessWidget {
  HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<Skeleton>(builder: ((context, value, child) {
              return Text(
                'Hi ${value.name}!',
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              );
            })),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List<Widget>.generate(
                  Provider.of<Skeleton>(context).servicesLabels.length,
                  (index) => ServicesCard(
                        index: index,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
