part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountFailure extends AccountState {
  final String message;

  AccountFailure(this.message);
}

final class AccountProfileLoad extends AccountState {
  final Account accountProfile;

  AccountProfileLoad(this.accountProfile);
}

final class AccountProfileSaved extends AccountState {
  final Account accountProfile;

  AccountProfileSaved(this.accountProfile);
}
