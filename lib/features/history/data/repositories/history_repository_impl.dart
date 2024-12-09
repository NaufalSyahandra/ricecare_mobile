import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/history/data/datasources/history_remote_datasource.dart';
import 'package:ricecare_mobile/features/history/data/models/detection_history_model.dart';
import 'package:ricecare_mobile/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDatasource historyDataSource;

  HistoryRepositoryImpl(this.historyDataSource);

  @override
  Future<Either<Failure, List<DetectionHistoryModel>>> getHistoryDetection() async {
    try {
      return Right(await historyDataSource.fetchHistoryList());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
