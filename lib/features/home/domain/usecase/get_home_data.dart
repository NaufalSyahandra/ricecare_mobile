import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:ricecare_mobile/features/home/domain/repositories/home_repository.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  Future<Either<Failure, List<HomeEntity>>> call() async {
    return await repository.getHomeData();
  }
}