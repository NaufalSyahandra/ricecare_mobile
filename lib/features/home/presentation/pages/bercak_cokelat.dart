import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BercakCokelatPage extends StatefulWidget {
  const BercakCokelatPage({super.key});

  @override
  _BercakCokelatPageState createState() => _BercakCokelatPageState();
}

class _BercakCokelatPageState extends State<BercakCokelatPage> {
  int _selectedSegment = 0;

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
            "Bercak Cokelat Padi",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              'images/hama_penyakit/bercak_cokelat.jpg',
              fit: BoxFit.fitHeight,
              width: 310.0,
              height: 480.0,
            ),
          ),
          const SizedBox(height: 16.0),
          buildCurativeContent(context),
        ],
      ),
    );
  }

  Widget buildCurativeContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("logos/rekomendasi_perawatan/bakteri.png",
                  width: 50, height: 50),
              const SizedBox(width: 8.0),
              const Text(
                "Penyebab",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Bakteri Xanthomonas oryzae pv. oryzae",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16.0),
          const Divider(color: Colors.grey),
          const SizedBox(height: 16.0),
          const Text(
            "Gejala",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("- Garis-garis hijau keabu-abuan pada daun"),
          const Text("- Daun menguning kemudian layu dan mati."),
          const Text(
              "- Cairan bakteri yang menyerupai susu terlihat menetes dari daun"),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSegment = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Cegah",
                      style: TextStyle(
                        color:
                            _selectedSegment == 0 ? Colors.black : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      height: 2.0,
                      width: 150.0,
                      color: _selectedSegment == 0
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSegment = 1;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Obati",
                      style: TextStyle(
                        color:
                            _selectedSegment == 1 ? Colors.black : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      height: 2.0,
                      width: 150.0,
                      color: _selectedSegment == 1
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          if (_selectedSegment == 0) ...[
            buildPreventionSection(),
          ] else if (_selectedSegment == 1) ...[
            buildTreatmentSection(),
          ],
        ],
      ),
    );
  }

  Widget buildPreventionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tindakan Pencegahan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 16.0),
        Text("1. Gunakan benih sehat dari sumber bersertifikat."),
        Text("2. Tanam varietas padi tahan penyakit."),
        Text("3. Tangani bibit dengan hati-hati saat pemindahan."),
        Text("4. Pastikan drainase lahan baik."),
        Text("5. Atur pemupukan nitrogen dengan bijak dan bertahap."),
        Text(
            "6. Berikan ekstra kalium bersama nitrogen terakhir jika cuaca mendukung."),
        Text("7. Hindari penggunaan urea."),
        Text("8. Singkirkan gulma dan inang alternatif di sekitar lahan."),
        Text("9. Bajak sisa-sisa tanaman yang dapat menjadi inang bakteri."),
        Text("10. Keringkan lahan di antara musim tanam."),
      ],
    );
  }

  Widget buildTreatmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildInfoWithImage(
                imagePath: "logos/rekomendasi_perawatan/ladybug.png",
                title: "Pengendalian Hayati",
                content:
                    "Hingga hari ini, tidak ada produk alami yang tersedia secara komersial untuk mengendalikan hawar daun bakteri pada padi. Penyemprotan produk berbahan dasar tembaga dapat membantu meringankan atau mengurangi gejala tetapi tidak dapat mengendalikan penyakit.",
              ),
              const Divider(height: 30, color: Colors.grey),
              buildChemicalControlSection(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoWithImage({
    required String title,
    required String imagePath,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(imagePath, width: 50, height: 50),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(content),
      ],
    );
  }

  Widget buildChemicalControlSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset("logos/rekomendasi_perawatan/chemistry.png",
                width: 50, height: 50),
            const SizedBox(width: 8.0),
            const Text(
              "Pengendalian Kimiawi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFFFDDAF)),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset("logos/rekomendasi_perawatan/caution.png",
                  width: 50, height: 50),
              const SizedBox(width: 8.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ingat bahwa anda harus",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "MENGGUNAKAN HANYA SALAH SATU",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "pengobatan berikut.",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25.0),
        buildChemicalOption(
          context,
          "Bakterisida",
          "logos/rekomendasi_perawatan/spray_bottle.png",
          "Streptomycin Sulfate 90.0%, Tetracycline hydrochloride 10.0% WP",
        ),
        const SizedBox(height: 16.0),
        buildChemicalOption(
          context,
          "Fungisida",
          "logos/rekomendasi_perawatan/spray_bottle.png",
          "Copper Sulphate Pentahydrate 6.0% SC",
        ),
        const SizedBox(height: 16.0),
        buildChemicalOption(
          context,
          "Fungisida",
          "logos/rekomendasi_perawatan/spray_bottle.png",
          "Copper Hydroxide 53.8% DF",
        ),
      ],
    );
  }

  Widget buildChemicalOption(
      BuildContext context, String title, String imagePath, String content) {
    return GestureDetector(
      onTap: () {
        // if (title == "Bakterisida") {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const StreptomycinSulfatePage()),
        //   );
        // } else if (title == "Fungisida" &&
        //     content.contains("Copper Sulphate")) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const CopperSulphatePentahydratePage()),
        //   );
        // } else if (title == "Fungisida" &&
        //     content.contains("Copper Hydroxide")) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const CopperHydroxidePage()),
        //   );
        // }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, width: 50, height: 50),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
