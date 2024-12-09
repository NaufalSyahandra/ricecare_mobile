import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/change_password_page.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/edit_profile_page.dart';

class AccountOptionsWidget extends StatelessWidget {
  const AccountOptionsWidget({super.key});

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
              title: const Text('Edit Profile'),
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
              title: const Text('Ubah Password'),
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
              title: const Text('Tentang kita'),
              trailing: Image.asset(
                'assets/images/logout.png',
                height: 24,
                width: 24,
              ),
              onTap: () {
                // Implementasi Tentang Kita
              },
            ),
          ],
        ),
      ),
    );
  }
}
