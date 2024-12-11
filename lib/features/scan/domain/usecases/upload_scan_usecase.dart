import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/scan/domain/entities/scan.dart';
import 'package:ricecare_mobile/features/scan/domain/repositories/scan_repository.dart';

class UploadScanUseCase {
  final ScanRepository _scanRepository;

  UploadScanUseCase(this._scanRepository);

  Future<Either<Failure, Scan>> call(Uint8List imageBytes) async {
    return await _scanRepository.uploadScan(imageBytes);
  }
}