import 'package:app/features/login/data/login_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const InitialLoginState());

  final LoginService service = LoginService();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequestedEvent) {
      yield* _logUserIn(event);
    }
  }

  Stream<LoginState> _logUserIn(LoginRequestedEvent event) async* {
    yield const LoginInProgressLoginState();
    final username = event.username;
    final password = event.password;

    try {
      final isAuthorized = await service.logIn(username, password);

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
