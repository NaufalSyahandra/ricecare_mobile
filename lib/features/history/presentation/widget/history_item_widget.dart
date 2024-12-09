import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  final String date;
  final String status;
  final String cause;
  final String recommendation;
  final String imagePath;

  const HistoryItem({
    super.key,
    required this.date,
    required this.status,
    required this.cause,
    required this.recommendation,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDetailDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 80, // Sesuaikan ukuran lebar
              height: 80, // Sesuaikan ukuran tinggi
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover, // Atur cara gambar ditampilkan
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text("Status: $status"),
                  Text("Penyebab: $cause"),
                  Text(
                    "Rekomendasi: $recommendation",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Detail Deteksi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    width: 100, // Sesuaikan ukuran lebar di dalam dialog
                    height: 100, // Sesuaikan ukuran tinggi di dalam dialog
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Waktu Deteksi:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(date),
                const SizedBox(height: 8.0),
                const Text(
                  "Diagnosis:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(status),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15B392),
                    ),
                    child: const Text("Lihat Pengobatan"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
