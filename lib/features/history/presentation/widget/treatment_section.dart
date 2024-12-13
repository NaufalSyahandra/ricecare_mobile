import 'package:flutter/material.dart';

class TreatmentSection extends StatelessWidget {
  final String name_disease;

  const TreatmentSection({super.key, required this.name_disease});

  @override
  Widget build(BuildContext context) {
    List<String> getMedicines(String disease) {
      switch (disease.toLowerCase()) {
        case 'brown spot':
          return [
            'Lakukan perawatan benih dengan Tiram, Kaptan atau Mankozeb pada 2 g/kg.',
            'Perlakukan benih dengan air panas 54°C selama 15 menit untuk hasil terbaik pada perkecambahan dan desinfeksi.',
            'Bakar tunggul dan jerami di lahan.',
            'Berikan formulasi bakteri rizosfer padi yang disebut Pseudomonas fluorescens dalam bedak bubuk dengan takaran 5–10 gram per kilogram.',
          ];
        case 'bacterial leaf blight':
          return [
            'Gunakan bakterisida berbahan dasar tembaga sebagai langkah pencegahan.',
            'Cabut dan musnahkan tanaman yang terinfeksi untuk mengurangi penyebaran bakteri.',
            'Gunakan agen pengendali hayati seperti Pseudomonas fluorescens.',
          ];
        case 'leaf blast':
          return [
            'Semprotkan fungisida Hexaconazole 10.0%, Tricyclazole 45.0% WG.',
          ];

        case 'leaf scald':
          return [
            'Rendam benih dengan metil tiofanat.',
            'Semprot daun menggunakan fungisida yang mengandung mankozeb, metil tiofanat @ 1,0 g/l atau tembaga oksiklorida.',
          ];
        case 'narrow brown spot':
          return [
            'Aplikasikan fungisida berbahan aktif seperti mankozeb, propikonazol, atau azoksistrobin jika gejala mulai terlihat.',
            'Cabut dan musnahkan bagian tanaman yang terinfeksi berat.',
            'Gunakan agen hayati seperti Trichoderma spp. untuk menekan pertumbuhan jamur.',
          ];
        default:
          return ['Informasi pengobatan tidak tersedia.'];
      }
    }

    final medicines = getMedicines(name_disease);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pengobatan:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...medicines.map(
          (tip) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  tip,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
