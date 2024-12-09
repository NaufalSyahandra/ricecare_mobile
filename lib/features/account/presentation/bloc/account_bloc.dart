import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/error/failure.dart';
import 'package:ricecare_mobile/core/usecase/usecase.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/fetch_profile.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/update_profile.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final FetchProfile _fetchProfile;
  final UpdateProfile _updateProfile;
  Account? _originalAccountProfile;

  AccountBloc({
    required FetchProfile fetchProfile,
    required UpdateProfile updateProfile,
  })  : _fetchProfile = fetchProfile,
        _updateProfile = updateProfile,
        super(AccountInitial()) {
    on<FetchingProfile>(_onAccountProfileLoad);
    on<UpdatingProfile>(_onUpdatedProfile);
    on<ResetAccountState>(_onResetAccountState);
  }

  Future<void> _onAccountProfileLoad(
      FetchingProfile event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    final response = await _fetchProfile(NoParams());

    response.fold(
          (failure) => emit(AccountFailure(failure.message)),
          (accountProfile) {
        _originalAccountProfile = accountProfile;
        emit(AccountProfileLoad(accountProfile));
      },
    );
  }

  Future<void> _onUpdatedProfile(
      UpdatingProfile event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    final response = await _updateProfile(
      UpdateProfileParams(
        name: event.name,
        username: event.username,
        email: event.email,
      ),
    );

    response.fold(
          (failure) => emit(AccountFailure(failure.message)),
          (updatedAccount) {
        emit(AccountProfileSaved(updatedAccount));
        emit(AccountProfileLoad(updatedAccount));
        _originalAccountProfile = updatedAccount;
      },
    );
  }

  Future<void> _onResetAccountState(
      ResetAccountState event, Emitter<AccountState> emit) async {
    if (_originalAccountProfile != null) {
      emit(AccountProfileLoad(_originalAccountProfile!));
    } else {
      emit(AccountInitial());
    }
  }
}