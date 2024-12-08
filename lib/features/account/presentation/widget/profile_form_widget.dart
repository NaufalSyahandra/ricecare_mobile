import 'package:flutter/material.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController usernameController;

  const ProfileFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Username',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Email',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
