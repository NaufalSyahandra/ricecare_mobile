import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
import 'package:ricecare_mobile/features/home/domain/repositories/home_repository.dart';

class GetDisease {
  final HomeRepository diseaseRepository; // Corrected from HomeRepository

  GetDisease(this.diseaseRepository); // Corrected constructor name

  Future<Either<Failure, List<DiseaseEntity>>> call() async {
    // Corrected method name
    return await diseaseRepository.fetchDisease();
  }
}
