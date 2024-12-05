import 'package:ricecare_mobile/features/account/domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.email,
    required super.name,
    required super.username,
  });

  factory AccountModel.fromJson(Map<String, dynamic> map) {
    return AccountModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
    );
  }
}