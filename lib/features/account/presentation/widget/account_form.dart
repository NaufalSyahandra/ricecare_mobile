import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';

class AccountForm extends StatelessWidget {
  final Account account;

  const AccountForm({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: account.name);
    final usernameController = TextEditingController(text: account.username);
    final emailController = TextEditingController(text: account.email);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nama Lengkap'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Nama Pengguna'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
