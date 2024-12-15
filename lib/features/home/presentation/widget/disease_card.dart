import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/disease_detail_page.dart';

class DiseaseCard extends StatelessWidget {
  final DiseaseEntity disease;

  const DiseaseCard({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DiseaseDetailPage(disease: disease);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white, // Latar belakang putih
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  disease.image_disease,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Center(
                      child: Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 50),
                      ),
                    );
                  },
                ),
              ),
              // Menambahkan Container untuk teks
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  disease.name_disease,
                  style: GoogleFonts.poppins(
                      color: Colors.black, // Warna teks hitam
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
