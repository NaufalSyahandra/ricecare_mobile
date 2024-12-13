import 'package:flutter/material.dart';

class PreventionSection extends StatelessWidget {
  final String name_disease;

  const PreventionSection({super.key, required this.name_disease});

  @override
  Widget build(BuildContext context) {
    List<String> getPreventionTips(String disease) {
      switch (disease.toLowerCase()) {
        case 'brown spot':
          return [
            'Tanam benih yang bebas penyakit.',
            'Atur jarak baris (lebar 15, 20 dan 25 cm).',
            'Hanya gunakan benih padi yang teruji dan bersertifikat untuk mencegah masuknya patogen tular benih ini ke daerah baru, atau peningkatan inokulum di daerah yang sudah terserang.',
            'Bakar tunggul untuk mengurangi infeksi pada musim berikutnya.',
            'Keringkan biji-bijian dengan benar sebelum disimpan untuk mengurangi perkembangan infeksi di kemudian hari.',
          ];
        case 'bacterial leaf blight':
          return [
            'Gunakan varietas padi yang tahan penyakit.',
            'Tanam benih bersertifikat dan bebas penyakit.',
            'Jaga drainase lahan agar tidak tergenang air.',
            'Hindari penggunaan pupuk nitrogen secara berlebihan karena dapat meningkatkan kerentanan.',
            'Lakukan rotasi tanaman untuk memutus siklus penyakit.',
          ];
        case 'leaf blast':
          return [
            'Gunakan benih yang sehat atau bersertifikat.',
            'Tanam varietas tangguh yang tersedia di daerah tersebut. Taburkan benih pada awal musim, setelah awal musim hujan,',
            'Hindari nitrogen berlebihan dan pisahkan pemberiannya menjadi dua kali atau lebih.',
            'Hindari stres kekeringan pada tanaman lengan pemberian irigasi yang teratur',
            'Pertahankan tinggi genangan yang tepat agar padi dapat tumbuh dengan baik.',
            'Jaga stabilitas pengairan dan hindari drainase pada sawah.',
          ];
        case 'leaf scald':
          return [
            'Jika tersedia, gunakan varietas yang tahan penyakit.',
            'Perbesar jarak antar tanaman saat penanaman.',
            'Pertahankan kadar silikon yang tinggi di tanah untuk mengurangi timbulnya penyakit dan mendapatkan hasil yang lebih besar.',
            'Hindari kadar nitrogen yang berlebihan selama pemupukan tanaman Anda.',
            'Lakukan pemberian nitrogen secara terpisah selama tahap anakan.',
            'Singkirkan gulma di lahan dan sekitarnya.',
            'Bajak sawah di bawah tunggul padi dan singkirkan tunas atau pucuk baru padi yang terinfeksi.',
          ];
        case 'narrow brown spot':
          return [
            'Gunakan varietas padi yang tahan terhadap Narrow Brown Spot.',
            'Jaga keseimbangan nutrisi, terutama kalium, karena kekurangan kalium dapat meningkatkan kerentanan.',
            'Hindari penggunaan pupuk nitrogen secara berlebihan.',
            'Lakukan rotasi tanaman untuk mengurangi spora jamur di lahan.',
            'Jaga drainase lahan agar tidak terlalu lembap.',
          ];
        default:
          return ['Informasi pencegahan tidak tersedia untuk penyakit ini.'];
      }
    }

    final preventionTips = getPreventionTips(name_disease);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pencegahan:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...preventionTips.map(
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
