import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';

class AccountLogout implements UseCase<void, NoParams> {
  final AccountRepository accountRepository;

  AccountLogout(this.accountRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return accountRepository.logout();
  }
}