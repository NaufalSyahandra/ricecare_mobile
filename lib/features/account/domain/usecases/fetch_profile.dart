import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';

class FetchProfile implements UseCase<Account, NoParams> {
  final AccountRepository accountRepository;

  FetchProfile(this.accountRepository);

  @override
  Future<Either<Failure, Account>> call(NoParams params) async {
    return accountRepository.fetchProfile();
  }
}
