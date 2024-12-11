import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:ricecare_mobile/core/api/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

// API client class to handle HTTP requests
class ApiClient {
  final http.Client httpClient;

  ApiClient(this.httpClient);

  // POST
  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final response = await httpClient.post(
      Uri.parse(endpoint),
      headers: await _headers(),
      body: json.encode(body),
    );
    return response;
  }

// POST (for multipart/form-data)
  Future<http.Response> postMultipart(String endpoint,
      {required Uint8List fileBytes}) async {
    final request = http.MultipartRequest('POST', Uri.parse(endpoint));

    // Set headers for multipart request
    request.headers.addAll(await _multipartHeaders());

    // Add the file to the request
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: 'upload.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    // Send the request
    final response = await httpClient.send(request);

    // Return the response
    return await http.Response.fromStream(response);
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
  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? body}) async {
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

  // Private method to generate headers for multipart requests
  Future<Map<String, String>> _multipartHeaders() async {
    final headers = {
      'Accept': 'application/json',
    };

    // Retrieve the token from SharedPreferences
    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Fetch user profile
  Future<Map<String, dynamic>> fetchUserProfile() async {
    final response = await get(Endpoints.userProfile);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }
}
