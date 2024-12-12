import 'package:flutter/material.dart';

class PreventionSection extends StatelessWidget {
  final String prevention;

  const PreventionSection({super.key, required this.prevention});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pencegahan:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          prevention,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
