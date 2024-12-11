import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/change_password_page.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/edit_profile_page.dart';

class AccountOptionsWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const AccountOptionsWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
              },
            ),
            const Divider(thickness: 1),
            ListTile(
              title: Text(
                'Ubah Password',
                style: GoogleFonts.poppins(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage()),
                );
              },
            ),
            const Divider(thickness: 1),
            ListTile(
              title: Text(
                'Tentang kita',
                style: GoogleFonts.poppins(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implementasi Tentang Kita
              },
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 20), // Add space before the logout button
            const Divider(thickness: 1), // Divider before logout option
            ListTile(
              title: Text(
                'Keluar',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.logout, color: Colors.red),
              onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
