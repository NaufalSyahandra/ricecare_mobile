import 'dart:convert';

import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      Endpoints.userRegister,
      body: {
        'username': username,
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password
      },
    );

    if (response.statusCode != 201) {
      final errorMessage = json.decode(response.body);
      throw ServerException('Gagal Register: ${errorMessage['message']}');
    }

    final jsonResponse = json.decode(response.body);
    final userData = jsonResponse['data'];

    return UserModel.fromJson(userData);
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      Endpoints.userLogin,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      final errorMessage = json.decode(response.body);
      throw ServerException('Gagal Login: ${errorMessage['message']}');
    }

    final jsonResponse = json.decode(response.body);

    final userData = jsonResponse['data'];
    String token = jsonResponse['token'];

    apiClient.setToken(token);

    return UserModel.fromJson(userData);
  }
}
