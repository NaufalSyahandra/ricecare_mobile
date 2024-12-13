import 'package:flutter/material.dart';

class SymptomsSection extends StatelessWidget {
  final String name_disease;

  const SymptomsSection({super.key, required this.name_disease});

  @override
  Widget build(BuildContext context) {
    List<String> getSymptomsTips(String disease) {
      switch (disease.toLowerCase()) {
        case 'brown spot':
          return [
            'Bintik-bintik oval dan melingkar dengan tepian cokelat tua.',
            'Biji bisa mengerut dan menjadi rapuh.',
            'Seluruh tanaman menunjukkan hawar bibit dan rebah kecambah.',
          ];
        case 'bacterial leaf blight':
          return [
            'Muncul bercak basah pada ujung atau tepi daun yang berubah menjadi kuning, kemudian cokelat.',
            'Daun mengering dan tampak seperti terbakar.',
            'Tanaman tumbuh kerdil dan jumlah anakan berkurang.',
            'Infeksi parah dapat menyebabkan kehilangan hasil panen yang signifikan.',
          ];
        case 'leaf blast':
          return [
            'Luka berwarna kuning atau hijau muda dengan tepian nekrotik (sel mati), dan titik pusat berwarna abu-abu hingga keputihan pada daun.',
            'Ruas-ruas batang juga dapat terserang sehingga menyebabkan kerusakan batang dan kematian bibit atau tanaman muda.',
            'Pada tahap pertumbuhan selanjutnya, pengisian bulir dan hasil gabah dapat terserang.',
          ];
        case 'leaf scald':
          return [
            'Muncul bercak abu-abu atau cokelat pada daun dengan tampilan basah.',
            'Bercak dapat menyatu, menyebabkan area nekrotik yang luas.',
            'Daun mengering dan melengkung, sehingga mengurangi fotosintesis.',
            'Infeksi parah dapat menyebabkan daun mati sebelum waktunya dan pengisian gabah terganggu.',
          ];
        case 'narrow brown spot':
          return [
            'Bercak cokelat sempit berbentuk lonjong pada daun, dengan ukuran sekitar 1-2 cm.',
            'Bercak sering memiliki tepi berwarna kuning atau keabu-abuan.',
            'Pada infeksi berat, bercak dapat menyatu, menyebabkan daun mengering.',
            'Tanaman yang terinfeksi parah mengalami penurunan fotosintesis, sehingga mengurangi hasil panen.',
          ];
        default:
          return ['Informasi pencegahan tidak tersedia untuk penyakit ini.'];
      }
    }

    final getSymptoms = getSymptomsTips(name_disease);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pencegahan:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...getSymptoms.map(
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