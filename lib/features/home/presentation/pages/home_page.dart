import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ricecare_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:ricecare_mobile/features/home/domain/usecase/get_home_data.dart';
import 'package:ricecare_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:ricecare_mobile/features/home/presentation/bloc/home_event.dart';
import 'package:ricecare_mobile/features/home/presentation/bloc/home_state.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/home_content.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/home_error.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/home_loading.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  String? _userName; // Menyimpan nama pengguna yang dimuat dari SharedPreferences

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(
      GetHomeData(HomeRepositoryImpl(HomeRemoteDataSourceImpl())),
    );
    _homeBloc.add(LoadHomeData());
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'Guest'; // Default "Guest" jika tidak ada userName
    });
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
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
                // Gambar profil di kiri
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 40, // Ukuran gambar profil lebih besar
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                // Teks "Selamat datang" di sebelah kanan
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const HomeLoadings(); // Menampilkan widget loading
            } else if (state is HomeLoaded) {
              return HomeContent(data: state.data); // Menampilkan konten halaman
            } else if (state is HomeError) {
              return HomeErrorWidget(message: state.message); // Menampilkan widget error
            }
            return const Center();
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: const NavbarWidget(initialIndex: 0), // Menampilkan Navbar
    );
  }
}
