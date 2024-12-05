import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/commons/widgets/loader.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signin_page.dart';
import 'package:ricecare_mobile/features/auth/presentation/widget/auth_button.dart';
import 'package:ricecare_mobile/features/auth/presentation/widget/auth_field.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }

            if (state is AuthSuccess) {
              showSnackbar(context, state.user.name);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  AuthField(
                    controller: _nameController,
                    labelText: 'Name',
                  ),
                  const SizedBox(height: 12),
                  AuthField(
                    controller: _usernameController,
                    labelText: 'UserName',
                  ),
                  const SizedBox(height: 12),
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
                  AuthButton(
                    text: "Sign Up",
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      context.read<AuthBloc>().add(
                            AuthSignup(
                              name: _nameController.text,
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Sudah punya akun? ',
                        style: Theme.of(context).textTheme.titleSmall,
                        children: const [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppPallete.buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
