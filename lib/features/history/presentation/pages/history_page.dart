import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/history/presentation/bloc/history_bloc.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/history_item_widget.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:ricecare_mobile/features/history/data/models/detection_history_model.dart'; // Import model

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil event untuk memuat riwayat
    context.read<HistoryBloc>().add(LoadHistoryEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15B392),
        toolbarHeight: 85.0,
        title: const Center(
          child: Text(
            "Riwayat Deteksi",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppPallete.darkBackgroundColor,
            ),
          ),
        ),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoadedState) {
            // Data diambil dari state.historyData
            final historyData = state.history;

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                return HistoryItem(
                  date: historyData[index].detection_date, // Mengambil tanggal deteksi
                  status: historyData[index].disease.name_disease, // Nama penyakit sebagai status
                  cause: historyData[index].disease.description, // Deskripsi penyakit sebagai penyebab
                  recommendation: historyData[index].prevention, // Rekomendasi pencegahan
                  imagePath: historyData[index].image_path, // Path gambar
                );
              },
            );
          } else {
            return const Center(child: Text('Gagal memuat data'));
          }
        },
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 1),
    );
  }
}