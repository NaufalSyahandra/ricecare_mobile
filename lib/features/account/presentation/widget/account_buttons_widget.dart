import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';

class AccountButtonsWidget extends StatelessWidget {
  const AccountButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tombol Edit Profil
        ElevatedButton(
          onPressed: () {
            // Aksi untuk mengedit profil
            // Bisa menavigasi ke halaman edit profil
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text('Edit Profil', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 16),

        // Tombol Logout
        ElevatedButton(
          onPressed: () {
            context.read<AccountBloc>().add(Logout());
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text('Logout', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
