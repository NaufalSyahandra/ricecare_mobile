part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class FetchingProfile extends AccountEvent {}

final class UpdatingProfile extends AccountEvent {
  final String username;
  final String name;
  final String email;

  UpdatingProfile({
    required this.username,
    required this.name,
    required this.email,
  });
}

final class ResetAccountState extends AccountEvent {}

final class UpdatingPassword extends AccountEvent {
  final PasswordParam params;

  UpdatingPassword({
    required this.params
  });
}