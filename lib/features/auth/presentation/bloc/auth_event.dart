part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

final class AuthSignup extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;

  AuthSignup({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({
    required this.email,
    required this.password,
  });
}
