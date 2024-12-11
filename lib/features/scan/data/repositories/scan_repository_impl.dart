import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/error/network_info.dart';
import 'package:ricecare_mobile/features/scan/data/datasources/scan_remote_datasources.dart';
import 'package:ricecare_mobile/features/scan/data/models/scan_model.dart';
import 'package:ricecare_mobile/features/scan/domain/repositories/scan_repository.dart';

class ScanRepositoryImpl implements ScanRepository {
  final ScanRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ScanRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ScanModel>> uploadScan(Uint8List imageBytes) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteScan = await remoteDataSource.uploadScan(imageBytes);
        return Right(remoteScan);
      } on ServerException catch(e) {
        return Left(Failure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}