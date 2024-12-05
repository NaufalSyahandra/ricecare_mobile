import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';

class AccountInfoWidget extends StatelessWidget {
  final Account account;

  const AccountInfoWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar Profil dengan efek neumorphism
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(-4, -4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 50, // Ukuran avatar lebih kecil
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Informasi Akun
        Text(
          'Nama: ${account.name}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Username: ${account.username}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Email: ${account.email}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
