import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_header_widget.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_options_widget.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signin_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(FetchingProfile());

    return Scaffold(
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountFailure) {
            // Show a popup message when there's a failure.
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          if (state is AccountLoggedOut) {
            // Navigate to LoginPage on successful logout
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountProfileLoad) {
              final profile = state.accountProfile;
              return Column(
                children: [
                  AccountHeaderWidget(profile: profile),
                  const SizedBox(height: 20),
                  AccountOptionsWidget(
                    onLogout: () {
                      context.read<AccountBloc>().add(Logout());
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 4),
    );
  }
}
