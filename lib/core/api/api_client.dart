import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// API client class to handle HTTP requests
class ApiClient {

  final http.Client httpClient;

  ApiClient(this.httpClient);

  // POST
  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await httpClient.post(
      Uri.parse(endpoint),
      headers: await _headers(),
      body: json.encode(body),
    );
    return response;
  }

  // GET
  Future<http.Response> get(String endpoint) async {
    final response = await httpClient.get(
      Uri.parse(endpoint),
      headers: await _headers(),
    );
    return response;
  }

  // PUT
  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await httpClient.put(
      Uri.parse(endpoint),
      headers: await _headers(),
      body: json.encode(body),
    );
    return response;
  }

  // DELETE
  Future<http.Response> delete(String endpoint) async {
    final response = await httpClient.delete(
      Uri.parse(endpoint),
      headers: await _headers(),
    );
    return response;
  }


  // token management

  // Set the token in SharedPreferences
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Clear the token from SharedPreferences
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Retrieve the token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Private method to generate headers
  Future<Map<String, String>> _headers() async {
    final headers = {
      'Content-Type': 'application/json',
    };

    // Retrieve the token from SharedPreferences
    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

}