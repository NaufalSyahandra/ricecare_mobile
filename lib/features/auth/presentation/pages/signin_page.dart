import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/commons/widgets/loader.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signup_page.dart';
import 'package:ricecare_mobile/features/auth/presentation/widget/auth_button.dart';
import 'package:ricecare_mobile/features/auth/presentation/widget/auth_field.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration and vsync
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the animations for scale and opacity
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Repeat the animation (scale and opacity)
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose the animation controller when the page is disposed
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keeping the original background (without gradient)
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }

            if (state is AuthSuccess) {
              showSnackbar(context, ' Welcome ${state.user.name}');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to left
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Apply scale and opacity animation to logo image
                  Center(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _opacityAnimation.value,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/logo_hijau.png', // Image logo
                        height: 200, // Adjust image size
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Text changed to "Masukkan Akun Anda"
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Masukkan Akun Anda', // Updated text
                      style: TextStyle(
                        fontSize: 24, // Increased font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AuthField(
                    controller: _emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 12),
                  AuthField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isObscure: true,
                  ),
                  const SizedBox(height: 24),
                  // Use AuthButton widget from auth_button.dart
                  AuthButton(
                    text: "Sign In",
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      context.read<AuthBloc>().add(
                            AuthSignIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Center "Belum punya akun? Daftar"
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: Theme.of(context).textTheme.titleSmall,
                          children: const [
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                color: AppPallete.buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
