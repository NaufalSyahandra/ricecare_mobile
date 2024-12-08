import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';

abstract interface class AccountRepository {
  // Future<Either<Failure, void>> logout();
  Future<Either<Failure, Account>> fetchProfile();
  Future<Either<Failure, Account>> updateProfile({
    required String name,
    required String username,
    required String email
  });
  // Future<void>updatingPassword(PasswordParam params);
}