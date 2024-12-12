import 'dart:convert';
import 'dart:typed_data';

import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/features/scan/data/models/scan_model.dart';

abstract class ScanRemoteDataSource {
  Future<ScanModel> uploadScan(Uint8List imageBytes);
}

class ScanRemoteDataSourceImpl implements ScanRemoteDataSource {
  final ApiClient apiClient;

  ScanRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ScanModel> uploadScan(Uint8List imageBytes) async {
    final response = await apiClient.postMultipart(
      Endpoints.scan,
      fileBytes: imageBytes,
    );

    if (response.statusCode == 200) {
      return ScanModel.fromJson(json.decode(response.body));
    } else {
      final errorMessage = json.decode(response.body);
      throw ServerException('Terjadi error saat scan: ${errorMessage['message']}');
    }
  }
}
