import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({super.key, required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 107, 107, 107),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
