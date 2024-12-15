import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:ricecare_mobile/features/home/presentation/widget/disease_section.dart';
import '../bloc/home_bloc.dart';

class HamaPenyakitPage extends StatelessWidget {
  const HamaPenyakitPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(LoadDiseaseEvent());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85.0,
        title: Text(
          "Hama & Penyakit",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Tinggi garis bawah
          child: Container(
            height: 0.2, // Ketebalan garis bawah
            color: Colors.black.withOpacity(0.2), // Warna garis bawah
          ),
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.9),
        // Putih dengan sedikit transparansi
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: GoogleFonts.poppins(),
                ),
              );
            } else if (state is HomeDiseaseLoadedState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: DiseaseSection(diseases: state.diseases),
              );
            }
            return const SizedBox.shrink(); // Return empty widget if no data
          },
        ),
      ),
    );
  }
}
