import 'package:flutter/material.dart';

class ServicesCard extends StatefulWidget {
  ServicesCard({super.key, required this.label, required this.icon});
  final String label;
  final IconData icon;
  bool isactive = true;

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.isactive ? 1.0 : 0.0,
      color: widget.isactive
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isactive = !widget.isactive;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon),
              Text(
                widget.label,
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
  }
}
