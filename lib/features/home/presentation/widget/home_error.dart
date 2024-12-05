import 'package:flutter/material.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;

  const HomeErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk refresh halaman
              Navigator.of(context).pop();
            },
            child: const Text("Coba Lagi"),
          ),
        ],
      ),
    );
  }
}
