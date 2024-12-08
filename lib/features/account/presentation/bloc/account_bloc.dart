import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/account_logout.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/fetch_profile.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/update_profile.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  // final AccountLogout _accountLogout;
  final FetchProfile _fetchProfile;
  final UpdateProfile _updateProfile;

  // final UpdatePassword _updatePassword;

  AccountBloc({
    // required AccountLogout accountLogout,
    required FetchProfile fetchProfile,
    required UpdateProfile updateProfile,
    // required UpdatePassword updatePassword
  })  : _fetchProfile = fetchProfile,
        // _accountLogout = accountLogout,
        _updateProfile = updateProfile,
        // _updatePassword = updatePassword,
        super(AccountInitial()) {
    on<FetchingProfile>(_onAccountProfileLoad);
    // on<Logout>(_onAccountLogout);
    on<UpdatingProfile>(_onUpdatedProfile);
    // on<UpdatingPassword>(_onUpdatedPassword);
  }

  //
  // Future<void> _onAccountLogout(
  //     Logout event,
  //     Emitter<AccountState> emit
  //     ) async {
  //   emit(AccountLoading());
  //
  //   final response = await _accountLogout(
  //       NoParams()
  //   );
  //
  //   response.fold(
  //         (failure) => emit(AccountFailure(failure.message)),
  //         (_) => emit(AccountLoggedOut()),
  //   );
  // }

  Future<void> _onAccountProfileLoad(
      FetchingProfile event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    final response = await _fetchProfile(NoParams());

    response.fold(
      (failure) => emit(AccountFailure(failure.message)),
      (accountProfile) => emit(AccountProfileLoad(accountProfile)),
    );
  }

  Future<void> _onUpdatedProfile(
    UpdatingProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());

    final response = await _updateProfile(
      UpdateProfileParams(
        name: event.name,
        username: event.username,
        email: event.email,
      ),
    );

    response.fold(
      (failure) {
        if (failure.message.contains('username')) {
          emit(AccountFailure('Username sudah terpakai'));
        } else if (failure.message.contains('email')) {
          emit(AccountFailure('Email sudah terpakai'));
        } else {
          emit(AccountFailure(failure.message));
        }
      },
      (updatedAccount) {
        emit(AccountProfileSaved(
            updatedAccount)); // Data terbaru dikirim ke state
        emit(AccountProfileLoad(updatedAccount)); // Load ulang data profil
      },
    );
  }
}
