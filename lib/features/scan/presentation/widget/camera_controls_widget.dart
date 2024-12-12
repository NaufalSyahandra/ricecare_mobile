// CameraControls widget remains the same
import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final VoidCallback onToggleFlash;
  final VoidCallback onTakePicture;
  final VoidCallback onPickImage;

  const CameraControls({
    super.key,
    required this.onToggleFlash,
    required this.onTakePicture,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 40,
          child: GestureDetector(
            onTap: onPickImage,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: const Icon(Icons.photo, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
            onTap: onTakePicture,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.withOpacity(0.5),
              child:
                  const Icon(Icons.camera_alt, color: Colors.white, size: 30),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 40,
          child: GestureDetector(
            onTap: onToggleFlash,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: const Icon(Icons.flash_off, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
