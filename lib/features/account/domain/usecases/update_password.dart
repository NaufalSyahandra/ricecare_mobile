import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';

class UpdatePassword implements UseCase<void, PasswordParam> {
  final AccountRepository accountRepository;

  UpdatePassword(this.accountRepository);

  @override
  Future<Either<Failure, void>> call(PasswordParam params) {
    return accountRepository.updatePassword(params);
  }
}

class PasswordParam {
  final String old_password;
  final String new_password;
  final String new_password_confirmation;

  PasswordParam({
    required this.old_password,
    required this.new_password,
    required this.new_password_confirmation
  });
}