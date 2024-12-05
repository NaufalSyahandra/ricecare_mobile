import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signin_page.dart';

class AccountContainerWidget extends StatelessWidget {
  const AccountContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<AccountBloc>(),
      child: Column(
        children: [
          _buildAccountSection(context),
          const SizedBox(height: 20),
          _buildAboutSection(context),
          const SizedBox(height: 40),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  // Updated to accept BuildContext
  Widget _buildAccountSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Akun',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPallete.backgroundColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildOptionRow(
            context: context,  // Pass context here
            icon: Icons.person,
            text: 'Ubah Profil',
            onTap: () {
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //   //   builder: (context) => ,
              //   // ),
              // );
            },
          ),
          _buildDivider(),
          _buildOptionRow(
            context: context,  // Pass context here
            icon: Icons.lock,
            text: 'Ubah Kata Sandi',
            onTap: () {
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //   //   builder: (context) => const ChangePasswordPage(),
              //   // ),
              // );
            },
          ),
        ],
      ),
    );
  }

  // Updated to accept BuildContext
  Widget _buildAboutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPallete.darkBackgroundColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildOptionRow(
            context: context,  // Pass context here
            icon: Icons.policy,
            text: 'Syarat dan Ketentuan',
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionRow(
            context: context,  // Pass context here
            icon: Icons.privacy_tip,
            text: 'Kebijakan Privasi',
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionRow(
            context: context,  // Pass context here
            icon: Icons.help,
            text: 'Pusat Bantuan',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Updated to accept BuildContext
  Widget _buildOptionRow({
    required BuildContext context,  // Add context parameter
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Opacity(
                opacity: 0.5,
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.darkBackgroundColor,
                ),
              ),
            ],
          ),
          const Opacity(
            opacity: 0.5,
            child: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Column(
      children: [
        SizedBox(height: 8),
        Divider(
          color: AppPallete.grayColor,
          thickness: 1,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
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
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              context.read<AccountBloc>().add(Logout()); // Dispatch logout event
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Keluar',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}