import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For loading spinner
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';
import 'package:ricecare_mobile/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:ricecare_mobile/features/scan/presentation/page/result_page.dart';
import 'package:ricecare_mobile/features/scan/presentation/widget/camera_controls_widget.dart';
import 'package:ricecare_mobile/features/scan/presentation/widget/image_confirmation_dialog.dart'; // Import your dialog

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ScanUploaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(scan: state.scan)),
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
              if (_isLoading || state is ScanLoading)
                const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
              CameraControls(
                onToggleFlash: () {
// Handle flash toggle
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

                      // Show the confirmation dialog
                      showImageConfirmationDialog(
                        context,
                        _imageBytes,
                        () {
                          Navigator.of(context).pop(); // Retake the picture
                          setState(() {
                            _isLoading = false; // Reset loading state
                            _imageBytes = null; // Clear image bytes
                          });
                        },
                        () {
                          context
                              .read<ScanBloc>()
                              .add(UploadScanEvent(imageBytes: _imageBytes!));
                          Navigator.of(context).pop(); // Close dialog
                        },
                      );
                    } catch (e) {
                      print('Failed to take picture: $e');
                      setState(() {
                        _isLoading = false; // Set loading false
                      });
                    }
                  }
                },
                onPickImage: () async {
                  // Handle picking image from gallery
                },
              ),
            ],
          ),
          bottomNavigationBar: const NavbarWidget(initialIndex: 2),
        );
      },
    );
  }
}
