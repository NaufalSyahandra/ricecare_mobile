import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/secrets/app_secrets.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart'; // Import AccountBloc
import 'package:ricecare_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ricecare_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signin_page.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signup_page.dart';
import 'package:ricecare_mobile/init_dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/domain/usecase/user_signup.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/screen/presentation/pages/splashscreen.dart';

// import 'package:ricecare_mobile/screens/add_note/add_note_screen.dart';
// import 'package:ricecare_mobile/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      // Register AuthBloc
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      // Register AccountBloc
      BlocProvider(
        create: (context) => serviceLocator<AccountBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightThemeMode,
      title: 'RiceCare',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
