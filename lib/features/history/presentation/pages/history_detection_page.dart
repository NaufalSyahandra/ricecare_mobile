import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';

class HistoryDetectionPage extends StatelessWidget {
  final DetectionHistory historyDetails;

  const HistoryDetectionPage({
    required this.historyDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.buttonColor,
        leading: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: BackButton(color: AppPallete.darkBackgroundColor),
        ),
        title: Text(
          'Detail Riwayat',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppPallete.darkBackgroundColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Jarak antara header dan gambar
          // Gambar di dalam ClipRRect dengan lekukan di semua sudut
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12), // Lekukan di semua sudut
              child: SizedBox(
                height: 300, // Tinggi gambar yang lebih panjang
                width: 200, // Lebar gambar yang lebih kecil
                child: Image.network(
                  historyDetails.image_path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Container untuk menambahkan efek shadow
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Warna bayangan lebih tipis
                    offset: const Offset(0, -1),
                    // Offset x dan y
                    blurRadius: 2, // Radius blur bayangan lebih kecil
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                // Set elevation ke 0 agar shadow dari Container yang terlihat
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  // Menghapus outline
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        historyDetails.disease.name_disease,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(thickness: 1, color: Colors.grey),
                      // Garis tipis
                      const SizedBox(height: 12),
                      const Text(
                        'Gejala:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        historyDetails.disease.symptoms,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.grey),
                      // Garis tipis
                      const SizedBox(height: 12),
                      const Text(
                        'Tindakan Pencegahan:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        historyDetails.prevention,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.grey),
                      // Garis tipis
                      const SizedBox(height: 12),
                      const Text(
                        'Pengendalian Hama:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'test', // Pastikan ada field ini
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
