part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountUserInformationFetched extends AccountEvent {
  const AccountUserInformationFetched();

  @override
  List<Object> get props => [];
}

class AccountUserUpdated extends AccountEvent {
  const AccountUserUpdated({
    required this.user,
  });

  final user_repo.User user;

  @override
  List<Object> get props => [user];
}

class AccountUserNameChanged extends AccountEvent {
  const AccountUserNameChanged(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class AccountCompanyChanged extends AccountEvent {
  const AccountCompanyChanged(this.companyName);

  final String companyName;

  @override
  List<Object> get props => [companyName];
}

class AccountSignOut extends AccountEvent {}
