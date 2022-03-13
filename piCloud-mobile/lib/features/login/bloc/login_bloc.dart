import 'package:app/features/login/data/login_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._service) : super(const InitialLoginState());

  final LoginService _service;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is CheckIfAlreadyLoggedEvent) {
      yield* _verifyIfUserIsLoggedIn(event);
    } else if (event is LoginRequestedEvent) {
      yield* _logUserIn(event);
    }
  }

  Stream<LoginState> _verifyIfUserIsLoggedIn(
    CheckIfAlreadyLoggedEvent event,
  ) async* {
    yield const CheckingIfUserIsAlreadyLoggedInState();

    try {
      final isLoggedIn = await _service.isLoggedIn();

      if (isLoggedIn) {
        yield const UserIsAlreadyLoggedState();
      } else {
        yield const LoginRequiredState();
      }
    } catch (exception) {
      yield const LoginRequiredState();
    }
  }

  Stream<LoginState> _logUserIn(LoginRequestedEvent event) async* {
    yield const LoginInProgressLoginState();
    final username = event.username;
    final password = event.password;

    try {
      final isAuthorized = await _service.logIn(username, password);

      if (isAuthorized) {
        yield const LoginSuccessLoginState();
      } else {
        yield const LoginFailedLoginState(
          errorMessage: 'Password or username is invalid.',
        );
      }
    } catch (exception) {
      yield LoginFailedLoginState(
        errorMessage: exception.toString(),
      );
    }
  }
}
