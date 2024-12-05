import 'package:ricecare_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:ricecare_mobile/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<HomeEntity> getHomeData() async {
    final model = await remoteDataSource.fetchHomeData();
    return model;
  }
}
