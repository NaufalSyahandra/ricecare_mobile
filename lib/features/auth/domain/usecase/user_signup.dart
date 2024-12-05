import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/auth/domain/entities/user.dart';
import 'package:ricecare_mobile/features/auth/domain/repositories/auth_repository.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) {
    return authRepository.signUpWithEmailAndPassword(
      name: params.name,
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String username;
  final String email;
  final String password;

  UserSignupParams({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
}