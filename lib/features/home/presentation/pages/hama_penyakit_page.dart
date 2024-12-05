import 'package:flutter/material.dart';

class HamaPenyakitPage extends StatelessWidget {
  const HamaPenyakitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hama & Penyakit'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Halaman Hama & Penyakit',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
