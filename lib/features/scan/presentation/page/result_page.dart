import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/history/presentation/pages/history_page.dart';
import 'package:ricecare_mobile/features/scan/domain/entities/scan.dart'; // Pastikan untuk mengimpor halaman utama

class ResultPage extends StatelessWidget {
  final Scan scan;

  const ResultPage({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HistoryPage()), // Ganti dengan halaman utama Anda
                  (route) => false, // Hapus semua rute sebelumnya
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nama Penyakit: ${scan.name_disease}'),
            Text('Gejala: ${scan.symptoms}'),
            Text('Pencegahan: ${scan.prevention}'),
            if (scan.image_path.isNotEmpty)
              Image.network(scan.image_path),
          ],
        ),
      ),
    );
  }
}