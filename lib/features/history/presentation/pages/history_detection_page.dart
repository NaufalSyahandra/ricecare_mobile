import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/symptoms_section.dart';
import '../widget/prevention_section.dart';
import '../widget/treatment_section.dart';

class HistoryDetectionPage extends StatefulWidget {
  final DetectionHistory historyDetails;

  const HistoryDetectionPage({
    required this.historyDetails,
    super.key,
  });

  @override
  State<HistoryDetectionPage> createState() => _HistoryDetectionPageState();
}

class _HistoryDetectionPageState extends State<HistoryDetectionPage> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.buttonColor,
        leading: const BackButton(color: AppPallete.darkBackgroundColor),
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
          const SizedBox(height: 16),
          _buildImage(),
          const SizedBox(height: 16), // Jarak antara gambar dan card
          Expanded(child: _buildCard()), // Menggunakan Expanded untuk Card
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3, // Panjang gambar
          width: MediaQuery.of(context).size.width * 0.6, // Lebar gambar
          child: Image.network(
            widget.historyDetails.image_path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    String name_disease = widget.historyDetails.disease.name_disease;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        // Menambahkan SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDiseaseTitle(),
            const SizedBox(height: 12),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 12),
            SymptomsSection(name_disease: name_disease),
            const SizedBox(height: 20),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 12),
            _buildSegmentControl(),
            const SizedBox(height: 16.0),
            _selectedSegment == 0
                ? PreventionSection(name_disease: name_disease)
                : TreatmentSection(name_disease: name_disease),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseTitle() {
    return Text(
      widget.historyDetails.disease.name_disease,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSegmentControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSegmentButton("Cegah", 0),
        _buildSegmentButton("Obati", 1),
      ],
    );
  }

  Widget _buildSegmentButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSegment = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: _selectedSegment == index ? Colors.black : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 2.0,
              width: 150.0,
              color:
                  _selectedSegment == index ? Colors.black : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
