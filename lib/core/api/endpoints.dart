import 'package:ricecare_mobile/core/secrets/app_secrets.dart';

class Endpoints {
  static const String baseUrl = AppSecrets.laravelBaseUrl;

  static String fullUrl(String endpoint) {
    final cleanedEndpoint =
        endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;

    return '$baseUrl/$cleanedEndpoint';
  }

  static final String userRegister = fullUrl('/register');
  static final String userLogin = fullUrl('/login');
  static final String userLogout = fullUrl('/logout');
  static final String updateProfile = fullUrl('/update-profile');
  static final String updatePassword = fullUrl('/update-password');
  static final String userProfile = fullUrl('/profile');
  static final String getHistory = fullUrl('/get-history');
  static final String getDetectionHistory = fullUrl('/get-detection-history');
  static String checkUsernameAvailability(String username) => fullUrl('check-username-availability?username=$username');
  static String checkEmailAvailability(String email) => fullUrl('check-username-availability?email=$email');
}
