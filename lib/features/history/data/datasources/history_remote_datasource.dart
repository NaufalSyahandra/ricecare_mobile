import 'dart:convert';

import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/features/history/data/models/detection_history_model.dart';

abstract class HistoryRemoteDatasource {
  Future<List<DetectionHistoryModel>> fetchHistoryList();
}

class HistoryRemoteDatasourceImpl implements HistoryRemoteDatasource {
  final ApiClient apiClient;

  HistoryRemoteDatasourceImpl(this.apiClient);

  @override
  Future<List<DetectionHistoryModel>> fetchHistoryList() async {
    try {

      final response = await apiClient.get(Endpoints.getDetectionHistory);

      if (response.statusCode != 200) {
        throw ServerException('gagal memuat data history Detection');
      }

      final jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];

      return data.map((e) => DetectionHistoryModel.fromJson(e)).toList();

    } catch (e) {
      throw ServerException('Terjadi error ketika mengambil data list history');
    }
  }
}
