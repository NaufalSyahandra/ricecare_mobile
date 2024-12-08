part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

// final class Logout extends AccountEvent{}

final class FetchingProfile extends AccountEvent{}

final class UpdatingProfile extends AccountEvent{
  final String username;
  final String name;
  final String email;

  UpdatingProfile({
    required this.username,
    required this.name,
    required this.email,
  });
}