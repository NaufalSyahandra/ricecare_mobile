import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/history/presentation/pages/history_page.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/prevention_section.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/symptoms_section.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/treatment_section.dart';
import 'package:ricecare_mobile/features/scan/domain/entities/scan.dart';

class ResultPage extends StatefulWidget {
  final Scan scan;

  const ResultPage({super.key, required this.scan});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _selectedSegment = 0; // To hold the selected segment

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.buttonColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppPallete.darkBackgroundColor),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HistoryPage()),
              // Navigate to HistoryPage
              (route) => false, // Remove all previous routes
            );
          },
        ),
        title: Text(
          'Hasil Scan',
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
          const SizedBox(height: 16), // Space between image and card
          Expanded(child: _buildCard()), // Use Expanded for the card
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
          height: MediaQuery.of(context).size.height * 0.3, // Image height
          width: MediaQuery.of(context).size.width * 0.6, // Image width
          child: Image.network(
            widget.scan.image_path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    String name_disease = widget.scan.name_disease;
    ;
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
// Adding SingleChildScrollView
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
      widget.scan.name_disease,
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
