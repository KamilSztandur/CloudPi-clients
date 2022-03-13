part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {
  const InitialLoginState();

  @override
  List<Object> get props => [];
}

class CheckingIfUserIsAlreadyLoggedInState extends LoginState {
  const CheckingIfUserIsAlreadyLoggedInState();

  @override
  List<Object> get props => [];
}

class UserIsAlreadyLoggedState extends LoginState {
  const UserIsAlreadyLoggedState();

  @override
  List<Object> get props => [];
}

class LoginRequiredState extends LoginState {
  const LoginRequiredState();

  @override
  List<Object> get props => [];
}

class LoginInProgressLoginState extends LoginState {
  const LoginInProgressLoginState();

  @override
  List<Object> get props => [];
}

class LoginSuccessLoginState extends LoginState {
  const LoginSuccessLoginState();

  @override
  List<Object> get props => [];
}

class LoginFailedLoginState extends LoginState {
  const LoginFailedLoginState({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
