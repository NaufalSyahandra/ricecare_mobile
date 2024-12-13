import 'package:flutter/material.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/hama_penyakit_page.dart'; // Import halaman HamaPenyakitPage

class HomeContent extends StatefulWidget {
  final List<HomeEntity> data;

  const HomeContent({super.key, required this.data});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Controller untuk PageView
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _autoScrollPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Fungsi untuk scroll otomatis dan kembali ke halaman pertama setelah halaman terakhir
  void _autoScrollPage() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        if (_pageController.page == 2) {
          _pageController.animateToPage(0,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        } else {
          _pageController.nextPage(
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        }
      }
      _autoScrollPage();
    });
  }

  // Fungsi untuk membuka URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row untuk statistik
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoCard(
                title: "Padi terdeteksi",
                value: "${widget.data.fold(0, (sum, item) => sum + item.total_deteksi)}",
                imagePath: "assets/images/search.png",
              ),
              const SizedBox(width: 8),
              _buildInfoCard(
                title: "Padi sehat",
                value: "${widget.data.fold(0, (sum, item) => sum + item.sehat)}",
                imagePath: "assets/images/padi_sehat.png",
              ),
              const SizedBox(width: 8),
              _buildInfoCard(
                title: "Padi sakit",
                value: "${widget.data.fold(0, (sum, item) => sum + item.sakit)}",
                imagePath: "assets/images/padi_sakit.png",
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Scrollable Card dengan PageView dan indikator
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: [
                    _buildScrollableCard(
                        imagePath: "assets/images/Frame2608559.png",
                        link:
                        "https://medium.com/@xenovandestra/tanaman-pepohonan-anti-hama-untuk-melindungi-padi-oryza-sativa-dari-berbagai-jenis-serangan-hama-69b620803a87"),
                    _buildScrollableCard(
                        imagePath: "assets/images/Frame2608560.png",
                        link: "https://example.com/page2"),
                    _buildScrollableCard(
                        imagePath: "assets/images/Frame2608561.png",
                        link: "https://example.com/page3"),
                  ],
                ),
                // Indikator titik di bawah
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3, // Jumlah halaman dalam PageView (sekarang 3)
                      effect: const WormEffect(
                        dotColor: AppPallete.backgroundColor,
                        activeDotColor: Colors.blue,
                        dotHeight: 8.0,
                        dotWidth: 8.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Tombol fitur sebagai Card
          _buildFeatureCards(),
        ],
      ),
    );
  }

  // Fungsi membuat info card
  Widget _buildInfoCard({
    required String title,
    required String value,
    required String imagePath,
  }) {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    imagePath,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.darkBackgroundColor,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppPallete.darkBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi membuat card scrollable dengan gambar
  Widget _buildScrollableCard({
    required String imagePath,
    required String link, // Add the link parameter
  }) {
    return GestureDetector(
      onTap: () {
        _launchURL(link); // Open the link when the card is tapped
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  // Fungsi membuat tombol fitur sebagai Card
  Widget _buildFeatureCards() {
    return Column(
      children: [
        _buildFeatureCard(
          imagePath: "assets/images/hama_penyakit.png",
          label: "Hama & Penyakit",
          onTap: () {
            // Navigasi ke halaman HamaPenyakitPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HamaPenyakitPage()),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildFeatureCard(
          imagePath: "assets/images/tips_budidaya.png",
          label: "Tips Budidaya",
        ),
        const SizedBox(height: 8),
        _buildFeatureCard(
          imagePath: "assets/images/peringatan_hama.png",
          label: "Peringatan Hama",
        ),
      ],
    );
  }

  // Fungsi membuat tombol fitur sebagai Card
  Widget _buildFeatureCard({
    required String imagePath,
    required String label,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              // Gambar kecil di pojok kiri atas
              Image.asset(
                imagePath,
                height: 32,
                width: 32,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              // Label
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.darkBackgroundColor,
                  ),
                ),
              ),
              // Ikon panah di sisi kanan
              const Icon(
                Icons.arrow_forward_ios,
                color: AppPallete.darkBackgroundColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}