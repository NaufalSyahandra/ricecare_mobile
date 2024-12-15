import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getHomeData();
  Future<Either<Failure, List<DiseaseEntity>>> fetchDisease();
}