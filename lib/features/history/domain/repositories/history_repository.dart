import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<DetectionHistory>>> getHistoryDetection();
}
