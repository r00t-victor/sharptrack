import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/skeleton.dart';

class ServicesCard extends StatefulWidget {
  ServicesCard({super.key, required this.index});
  final int index;
  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Skeleton>(
      builder: (context, value, child) {
        return Card(
          elevation: 1.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(value.servicesIcons[widget.index]),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      value.servicesLabels[widget.index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 107, 107, 107),
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: Provider.of<Skeleton>(context)
                      .servicesActive[widget.index],
                  onChanged: (bool v) {
                    setState(() {
                      Provider.of<Skeleton>(context, listen: false)
                          .toggleServices(widget.index, context, v);
                    });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
