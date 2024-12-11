import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:ricecare_mobile/features/scan/presentation/widget/camera_controls_widget.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          if (_isCameraInitialized)
            Positioned.fill(child: CameraPreview(_cameraController!))
          else
            const Center(child: CircularProgressIndicator()),
          CameraControls(
            onToggleFlash: () {
              // Menangani toggle flash
            },
            onTakePicture: () async {
              // Menangani pengambilan gambar
              if (_cameraController != null &&
                  _cameraController!.value.isInitialized) {
                try {
                  final XFile file = await _cameraController!.takePicture();
                  final String path = await _getSavePath();
                  await file.saveTo(path);
                  print('Gambar disimpan: $path');
                } catch (e) {
                  print('Gagal mengambil gambar: $e');
                }
              }
            },
            onPickImage: () async {
              // Menangani pemilihan gambar dari galeri
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 2),
    );
  }

  Future<String> _getSavePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}
