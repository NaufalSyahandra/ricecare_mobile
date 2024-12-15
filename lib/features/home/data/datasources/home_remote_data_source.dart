import 'dart:convert';
import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/features/home/data/models/disease_model.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> fetchHomeData();
  Future<List<DiseaseModel>> fetchDiseaseData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<HomeModel>> fetchHomeData() async {
    try {
      final response = await apiClient.get(Endpoints.getHistory);

      if (response.statusCode != 200) {
        throw ServerException('Gagal memuat data list home');
      }

      final jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];

      return data.map((e) => HomeModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException('Terjadi error ketika mengambil data list home');
    }
  }

  @override
  Future<List<DiseaseModel>> fetchDiseaseData() async { // Implement this method
    try {
      final response = await apiClient.get(Endpoints.getDisease); // Update with the correct endpoint

      if (response.statusCode != 200) {
        throw ServerException('Gagal memuat data list penyakit');
      }

      final jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];

      return data.map((e) => DiseaseModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException('Terjadi error ketika mengambil data list penyakit');
    }
  }
}
