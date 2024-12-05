import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  Future<HomeEntity> call() async {
    return await repository.getHomeData();
  }
}
