import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/penyakit_garis_merah.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/tungro.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/ulat_kantung_padi.dart';

import 'bercak_cokelat.dart';
import 'bercak_cokelat_padi.dart';
import 'busuk_batang_pada_padi.dart';
import 'gosong_bulir_padi.dart';
import 'hawar_bakteri_pada_padi.dart';
import 'jelaga_palsu.dart';
import 'lepuh_daun_padi.dart';

class HamaPenyakitPage extends StatelessWidget {
  const HamaPenyakitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15B392),
        toolbarHeight: 85.0,
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Center(
          child: Text(
            "Hama & Penyakit",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Penyakit Berdasarkan Tahapan",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Semua hama dan penyakit yang mungkin\n"
                  "muncul di tanaman Anda pada tahap\n"
                  "yang berbeda.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection("Tahap Pembibitan", [
              _buildImageRow(
                context,
                "images/hama_penyakit/ulat_kantung.jpg",
                "Serangga",
                "Ulat Kantung Padi",
                "images/hama_penyakit/bercak_cokelat.jpg",
                "Jamur",
                "Bercak Cokelat Padi",
                UlatKantungPadiPage(),
                BercakCokelatPage(),
              ),
            ]),
            _buildSection("Tahap Vegetatif", [
              _buildImageRow(
                context,
                "images/hama_penyakit/busuk_batang.jpg",
                "Jamur",
                "Busuk Batang pada Padi",
                "images/hama_penyakit/lepuh_daun.jpg",
                "Jamur",
                "Lepuh Daun Padi",
                BusukBatangPadiPage(),
                LepuhDaunPadiPage(),
              ),
            ]),
            _buildSection("Tahap Berbunga", [
              _buildImageRow(
                context,
                "images/hama_penyakit/hawar_bakteri.jpg",
                "Bakteri",
                "Hawar Bakteri pada Padi",
                "images/hama_penyakit/tungro.jpg",
                "Virus",
                "Tungro",
                HawarPage(),
                TungroPage(),
              ),
            ]),
            _buildSection("Tahap Berbuah", [
              _buildImageRow(
                context,
                "images/hama_penyakit/gosong_bulir.jpg",
                "Jamur",
                "Gosong Bulir Padi",
                "images/hama_penyakit/garis_merah.jpg",
                "Jamur",
                "Penyakit Garis Merah",
                GosongBulirPadiPage(),
                PenyakitGarisMerahPage(),
              ),
            ]),
            _buildSection("Tahap Panen", [
              _buildImageRow(
                context,
                "images/hama_penyakit/jelaga_palsu.jpg",
                "Jamur",
                "Jelaga Palsu",
                "images/hama_penyakit/bercak_cokelat_padi.jpg",
                "Jamur",
                "Bercak Cokelat Padi",
                JelagaPalsuPage(),
                BercakCokelatPadiPage(),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // Membuat bagian untuk setiap tahap
  Widget _buildSection(String title, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 23,
          ),
        ),
        const SizedBox(height: 16),
        ...rows,
        const SizedBox(height: 24),
      ],
    );
  }

  // Membuat baris gambar dan teks
  Widget _buildImageRow(
      BuildContext context,
      String imagePath1,
      String title1,
      String subtitle1,
      String imagePath2,
      String title2,
      String subtitle2,
      Widget page1,
      Widget page2,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildImageCard(context, imagePath1, title1, subtitle1, page1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildImageCard(context, imagePath2, title2, subtitle2, page2),
        ),
      ],
    );
  }

  // Membuat kartu gambar yang bisa diklik
  Widget _buildImageCard(
      BuildContext context,
      String imagePath,
      String title,
      String subtitle,
      Widget page,
      ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Stack(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(19.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

