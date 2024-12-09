import 'dart:convert';

import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/features/account/data/models/account_model.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/update_password.dart';

abstract interface class AccountRemoteDataSources {
  // Future<void> logout();

  Future<AccountModel> fetchProfile();

  Future<AccountModel> updateProfile({
    required String name,
    required String email,
    required String username,
  });

Future<void>updatingPassword(PasswordParam params);
}

class AccountRemoteDataSourcesImpl extends AccountRemoteDataSources {
  final ApiClient apiClient;

  AccountRemoteDataSourcesImpl(this.apiClient);

  // @override
  // Future<void> logout() async {
  //   final response = await apiClient.post(Endpoints.userLogout);
  //
  //   if (response.statusCode != 200) {
  //     final errorMessage = json.decode(response.body);
  //     throw ServerException('Gagal Logout: ${errorMessage['message']}');
  //   }
  //
  //   apiClient.clearToken();
  // }

  @override
  Future<AccountModel> fetchProfile() async {
    final response = await apiClient.get(Endpoints.userProfile);

    if (response.statusCode != 200) {
      final errorMessage = json.decode(response.body);
      throw ServerException('Gagal memuat data: ${errorMessage['message']}');
    }

    final jsonResponse = json.decode(response.body);

    return AccountModel.fromJson(jsonResponse);
  }

  @override
  Future<AccountModel> updateProfile({
    required String name,
    required String username,
    required String email,
  }) async {
    final response = await apiClient.put(Endpoints.updateProfile,
        body: {'username': username, 'name': name, 'email': email});

    if (response.statusCode != 200) {
      final errorMessage = json.decode(response.body);
      throw ServerException('Gagal update data: ${errorMessage['message']}');
    }

    final jsonResponse = json.decode(response.body);

    return AccountModel.fromJson(jsonResponse);
  }

  @override
  Future<void> updatingPassword(PasswordParam params) async {
    final response = await apiClient.put(Endpoints.updatePassword, body: {
      'old_password': params.old_password,
      'new_password': params.new_password,
      'new_password_confirmation': params.new_password_confirmation
    });

    if (response.statusCode != 204) {
      final errorMessage = json.decode(response.body);
      throw ServerException(
          'Gagal update password: ${errorMessage['message']}');
    }
  }
}
