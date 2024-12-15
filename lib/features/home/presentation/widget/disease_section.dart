import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
import 'disease_card.dart';

class DiseaseSection extends StatelessWidget {
  final List<DiseaseEntity> diseases;

  const DiseaseSection({super.key, required this.diseases});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Penyakit Berdasarkan Tahapan",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Semua hama dan penyakit yang mungkin\n"
              "muncul di tanaman Anda pada tahap\n"
              "yang berbeda.",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (diseases.isEmpty)
            const Center(child: Text("Tidak ada data penyakit."))
          else
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // Adjust aspect ratio as needed
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return DiseaseCard(disease: diseases[index]);
              },
            ),
        ],
      ),
    );
  }
}
