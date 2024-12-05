import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/auth/domain/usecase/user_signin.dart';
import 'package:ricecare_mobile/features/auth/domain/usecase/user_signup.dart';
import 'package:ricecare_mobile/features/auth/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignIn _userSignIn;

  AuthBloc({
    required UserSignup userSignup,
    required UserSignIn userSignIn,
  })  : _userSignup = userSignup,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignup);
    on<AuthSignIn>(_onAuthSignIn);
  }

  FutureOr<void> _onAuthSignup(
    AuthSignup event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _userSignup(UserSignupParams(
      name: event.name,
      username: event.username,
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  FutureOr<void> _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
