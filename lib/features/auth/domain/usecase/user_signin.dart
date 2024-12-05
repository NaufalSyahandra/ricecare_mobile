import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/auth/domain/entities/user.dart';
import 'package:ricecare_mobile/features/auth/domain/repositories/auth_repository.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository _authRepository;

  UserSignIn(AuthRepository authRepository) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) {
    return _authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}