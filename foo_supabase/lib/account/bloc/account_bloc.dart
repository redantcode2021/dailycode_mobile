import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart' as user_repo;

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._userRepository) : super(const AccountState()) {
    on<AccountUserInformationFetched>(_onGetUserInformation);
    on<AccountUserUpdated>(_onUpdateUser);
    on<AccountSignOut>(_onSignOut);
    on<AccountUserNameChanged>(_onUserNameChanged);
    on<AccountCompanyChanged>(_onCompanyNameChanged);
  }

  final user_repo.UserRepository _userRepository;

  Future<FutureOr<void>> _onGetUserInformation(
    AccountUserInformationFetched event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      final user = await _userRepository.getUser();
      emit(
        state.copyWith(
          status: AccountStatus.success,
          user: user,
          userName: UserName.dirty(user.userName),
          companyName: CompanyName.dirty(user.companyName),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  Future<FutureOr<void>> _onUpdateUser(
    AccountUserUpdated event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await _userRepository.updateUser(user: event.user);
      emit(state.copyWith(status: AccountStatus.update, valid: false));
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  Future<FutureOr<void>> _onSignOut(
    AccountSignOut event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await _userRepository.signOut();
      emit(state.copyWith(status: AccountStatus.success));
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  FutureOr<void> _onUserNameChanged(
    AccountUserNameChanged event,
    Emitter<AccountState> emit,
  ) {
    final userName = UserName.dirty(event.userName);
    emit(
      state.copyWith(
        status: AccountStatus.edit,
        userName: userName,
        valid: Formz.validate([userName, state.companyName]),
      ),
    );
  }

  FutureOr<void> _onCompanyNameChanged(
    AccountCompanyChanged event,
    Emitter<AccountState> emit,
  ) {
    final companyName = CompanyName.dirty(event.companyName);
    emit(
      state.copyWith(
        status: AccountStatus.edit,
        companyName: companyName,
        valid: Formz.validate([companyName, state.userName]),
      ),
    );
  }
}
