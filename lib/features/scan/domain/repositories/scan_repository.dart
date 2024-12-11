import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/scan/data/models/scan_model.dart';

abstract class ScanRepository {
  Future<Either<Failure, ScanModel>> uploadScan(Uint8List imageBytes);
}