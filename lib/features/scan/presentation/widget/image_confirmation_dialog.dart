import 'dart:typed_data';
import 'package:flutter/material.dart';

void showImageConfirmationDialog(BuildContext context, Uint8List? imageBytes, Function onRetry, Function onProcess) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Konfirmasi Gambar', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              if (imageBytes != null)
                Image.memory(imageBytes, height: 150, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => onRetry(),
                    child: const Text('Ambil Ulang'),
                  ),
                  ElevatedButton(
                    onPressed: () => onProcess(),
                    child: const Text('Proses'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}