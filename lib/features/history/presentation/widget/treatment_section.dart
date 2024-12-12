import 'package:flutter/material.dart';

class TreatmentSection extends StatelessWidget {
  const TreatmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Pengobatan:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Pengobatan yang direkomendasikan untuk penyakit ini.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
