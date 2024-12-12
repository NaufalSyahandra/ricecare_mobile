import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:ricecare_mobile/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:ricecare_mobile/features/scan/presentation/page/result_page.dart';
import 'package:ricecare_mobile/features/scan/presentation/widget/camera_controls_widget.dart';
import 'package:ricecare_mobile/features/scan/domain/entities/scan.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isLoading = false;
  Uint8List? _imageBytes;

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
    return BlocConsumer<ScanBloc, ScanState>(
      listener: (context, state) {
        if (state is ScanError) {
          // Tampilkan pesan kesalahan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ScanUploaded) {
          // Navigasi ke halaman baru setelah pemrosesan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultPage(scan: state.scan)),
          );
        }
      },
      builder: (context, state) {
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
                  if (_cameraController != null &&
                      _cameraController!.value.isInitialized) {
                    setState(() {
                      _isLoading = true; // Set loading true
                    });

                    try {
                      final XFile file = await _cameraController!.takePicture();
                      _imageBytes = await file.readAsBytes();

                      // Tampilkan gambar untuk konfirmasi
                      _showImageConfirmationDialog(context);
                    } catch (e) {
                      print('Gagal mengambil gambar: $e');
                      setState(() {
                        _isLoading = false; // Set loading false
                      });
                    }
                  }
                },
                onPickImage: () async {
                  // Menangani pemilihan gambar dari galeri
                },
              ),
              if (_isLoading) const Center(child: CircularProgressIndicator()), // Tampilkan loading
            ],
          ),
          bottomNavigationBar: const NavbarWidget(initialIndex: 2),
        );
      },
    );
  }

  void _showImageConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Konfirmasi Gambar', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                if (_imageBytes != null)
                  Image.memory(
                    _imageBytes!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Ambil ulang gambar
                      },
                      child: const Text('Ambil Ulang'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Kirim gambar ke bloc untuk diupload
                        context.read<ScanBloc>().add(UploadScanEvent(imageBytes: _imageBytes!));
                        Navigator.of(context).pop(); // Tutup dialog
                      },
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
}