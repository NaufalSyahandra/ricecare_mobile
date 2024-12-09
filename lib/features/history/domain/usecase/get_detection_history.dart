import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';
import 'package:ricecare_mobile/features/history/domain/repositories/history_repository.dart';

class GetDetectionHistory {
  final HistoryRepository repository;

  GetDetectionHistory({required this.repository});

  Future<Either<Failure, List<DetectionHistory>>> call() async {
    return await repository.getHistoryDetection();
  }
}
