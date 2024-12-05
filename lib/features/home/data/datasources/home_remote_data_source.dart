import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> fetchHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeModel> fetchHomeData() async {
    // Simulasi data dari API
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    return const HomeModel(
      detected: 11,
      healthy: 7,
      infected: 4,
    );
  }
}
