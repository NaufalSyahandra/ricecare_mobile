import 'package:ricecare_mobile/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.email,
      required super.name,
      required super.username,
      });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
    );
  }
}
