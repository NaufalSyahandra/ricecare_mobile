import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? _userName;
  String? _profilePicture;

  @override
  void initState() {
    super.initState();
    _homeBloc = GetIt.instance<HomeBloc>();
    _homeBloc.add(LoadHomeEvent());
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'Guest';
      _profilePicture = prefs.getString('profile_picture');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Reduced height
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppPallete.backgroundColor,
                  AppPallete.backgroundColor,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppPallete.darkBackgroundColor,
                  width: 0.2,
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0), // Reduced padding
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 30, // Reduced radius
                        backgroundImage: _profilePicture != null
                            ? NetworkImage(_profilePicture!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                        child: _profilePicture == null
                            ? const Icon(Icons.person,
                                size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    // Reduced padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.65,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "Selamat datang, ",
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 20, // Reduced font size
                                color: AppPallete.primaryTextColor,
                              ),
                              children: [
                                TextSpan(
                                  text: _userName ?? 'Loading...',
                                  style: GoogleFonts.radioCanada(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20, // Reduced font size
                                    color: AppPallete.primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: BlocProvider(
        create: (_) => _homeBloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Loader();
            } else if (state is HomeLoadedState) {
              return HomeContent(data: state.home);
            } else if (state is HomeErrorState) {
              return HomeErrorWidget(message: state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      // backgroundColor: AppPallete.scaffoldBackgroundColor,
      bottomNavigationBar: const NavbarWidget(initialIndex: 0),
    );
  }
}
