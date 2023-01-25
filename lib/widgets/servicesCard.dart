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
          elevation: value.servicesActive[widget.index] ? 1.0 : 0.0,
          color: value.servicesActive[widget.index]
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: () {
              setState(() {
                Provider.of<Skeleton>(context, listen: false)
                    .toggleServices(widget.index, context);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(value.servicesIcons[widget.index]),
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
            ),
          ),
        );
      },
    );
  }
}
