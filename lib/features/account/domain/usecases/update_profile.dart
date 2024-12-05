import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';

class UpdateProfile implements UseCase<Account, UpdateProfileParams> {
  final AccountRepository accountRepository;

  UpdateProfile(this.accountRepository);

  @override
  Future<Either<Failure, Account>> call(UpdateProfileParams params) async {
    return accountRepository.updateProfile(
      name: params.name,
      username: params.username,
      email: params.email,
    );
  }
}

class UpdateProfileParams {
  final String name;
  final String username;
  final String email;

  UpdateProfileParams({
    required this.name,
    required this.username,
    required this.email
  });
  }