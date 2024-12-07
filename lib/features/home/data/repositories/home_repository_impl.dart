import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:ricecare_mobile/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HomeEntity>>> getHomeData() async {
    try {
      final homeData = await remoteDataSource.fetchHomeData();
      return Right(homeData);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}