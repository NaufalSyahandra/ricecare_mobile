import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/commons/widgets/loader.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/home_content.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/home_error.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/theme/app_pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  String? _userName; // Menyimpan nama pengguna yang dimuat dari SharedPreferences
  String? _profilePicture; // Menyimpan nama pengguna yang dimuat dari SharedPreferences

  @override
  void initState() {
    super.initState();
    _homeBloc = GetIt.instance<HomeBloc>();
    _homeBloc.add(LoadHomeEvent()); // Memuat data saat halaman dimuat
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'Guest'; // Default "Guest" jika tidak ada userName
      _profilePicture = prefs.getString('profile_picture'); // Default "Guest" jika tidak ada userName
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Menentukan tinggi AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Menghilangkan ikon back
          flexibleSpace: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 40, // Ukuran gambar profil lebih besar
                    backgroundImage: _profilePicture != null ? NetworkImage(_profilePicture!) : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0), // Memberikan jarak antara gambar dan teks
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat datang, ${_userName ?? 'Loading...'}!",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Ukuran teks yang lebih besar
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppPallete.backgroundColor, // Warna AppBar yang menarik
        ),
      ),
      body: BlocProvider(
        create: (_) => _homeBloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            // Menangani HomeError, jika ada error
            if (state is HomeErrorState) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              // Menampilkan loader saat data masih dimuat
              return const Loader();
            } else if (state is HomeLoadedState) {
              // Menampilkan data jika berhasil dimuat
              return HomeContent(data: state.home);
            } else if (state is HomeErrorState) {
              // Menampilkan error widget jika ada kesalahan
              return HomeErrorWidget(message: state.message);
            }
            return const Center(child: CircularProgressIndicator()); // Default loading indicator jika tidak ada state yang cocok
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: const NavbarWidget(initialIndex: 0),
    );
  }
}