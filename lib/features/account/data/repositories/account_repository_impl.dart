import 'package:either_dart/src/either.dart';
import 'package:ricecare_mobile/core/error/exception.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/features/account/data/datasources/account_remote_datasource.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSources remoteDataSources;

  AccountRepositoryImpl(this.remoteDataSources);

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSources.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Account>> fetchProfile() async {
    try {
      final profile =  await remoteDataSources.fetchProfile();
      return Right(profile);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Account>> updateProfile({
    required String username,
    required String name,
    required String email
  }) async {
    try {
      return Right(await remoteDataSources.updateProfile(
          username: username,
          name: name,
          email: email
      ));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  // @override
  // Future<Either<Failure, void>> updatePassword(PasswordParam params) async {
  //   try {
  //     return Right(await remoteDatasources.updatingPassword(params));
  //   } on ServerException catch (e) {
  //     return Left(Failure(e.message));
  //   }
  // }

}