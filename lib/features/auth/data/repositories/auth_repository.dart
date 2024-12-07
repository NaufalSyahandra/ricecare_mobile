import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ricecare_mobile/features/auth/domain/entities/user.dart';
import 'package:ricecare_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    return await _handleAuthOperation(
          () async {
        final user = await remoteDatasource.signUpWithEmailAndPassword(
          name: name,
          username: username,
          email: email,
          password: password,
        );
        await _saveUserName(user.username, user.profile_picture); // Simpan username ke SharedPreferences
        return user;
      },
    );
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _handleAuthOperation(
          () async {
        final user = await remoteDatasource.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _saveUserName(user.username, user.profile_picture); // Simpan username ke SharedPreferences
        return user;
      },
    );
  }

  /// Menangani operasi autentikasi dengan error handling.
  Future<Either<Failure, User>> _handleAuthOperation(
      Future<User> Function() operation) async {
    try {
      final user = await operation();
      return Right(user);
    } on ServerException catch (e) {
      return Left(
        Failure(e.message),
      );
    }
  }

  /// Simpan nama pengguna ke SharedPreferences.
  Future<void> _saveUserName(String username, String profile_picture) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('profile_picture', profile_picture);
  }
}
