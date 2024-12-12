part of 'scan_bloc.dart';

sealed class ScanEvent {}

class UploadScanEvent extends ScanEvent {
  final Uint8List imageBytes;

  UploadScanEvent({required this.imageBytes});
}