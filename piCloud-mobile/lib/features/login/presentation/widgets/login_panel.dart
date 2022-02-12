import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/login/bloc/login_bloc.dart';
import 'package:app/features/login/data/login_service.dart';
import 'package:app/features/login/presentation/widgets/login_button.dart';
import 'package:app/features/login/presentation/widgets/password_input_field.dart';
import 'package:app/features/login/presentation/widgets/username_input_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_progress_indicator.dart';

class LoginPanel extends StatefulWidget {
  const LoginPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPanelState();
}

class _LoginPanelState extends State<LoginPanel> {
  late LoginProgressIndicator loginIndicator;
  late final _bloc = LoginBloc(LoginService(context.read()));
  String? _username, _password;

  @override
  void initState() {
    loginIndicator = LoginProgressIndicator();
    _bloc.add(
      const CheckIfAlreadyLoggedEvent(),
    );

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: _blocListener,
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginRequiredState) {
              return _buildLoginPanel(state);
            } else if (state is UserIsAlreadyLoggedState) {
              return Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headline4,
              );
            } else {
              return const CircularProgressIndicator(color: Colors.white);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginPanel(LoginState state) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(vertical: 20),
      contentPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 30,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 10),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: SingleChildScrollView(
            child: Column(
              children: [
                UsernameInputField(
                  defaultValue: _username,
                  onChanged: (value) => _username = value,
                  onSubmitted: _onLoginPressed,
                ),
                const SizedBox(height: 10),
                PasswordInputField(
                  onPasswordChanged: (value) => _password = value,
                  onSubmitted: _onLoginPressed,
                ),
                const SizedBox(height: 10),
                _getLoginMessageIfAny(state),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      actions: [LoginButton(onPressed: _onLoginPressed)],
    );
  }

  Widget _getLoginMessageIfAny(LoginState state) {
    String errorMessage;

    if (state is LoginFailedLoginState) {
      errorMessage = state.errorMessage;
    } else {
      errorMessage = '';
    }

    return Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  void _onLoginPressed() => setState(() {
        _bloc.add(
          LoginRequestedEvent(
            password: _password ?? '',
            username: _username ?? '',
          ),
        );
      });

  void _blocListener(BuildContext context, LoginState state) => setState(() {
        if (state is UserIsAlreadyLoggedState) {
          AutoRouter.of(context).replaceAll(const [HomeRoute()]);
        }

        if (state is LoginInProgressLoginState) {
          loginIndicator.show(context);
        } else if (state is LoginSuccessLoginState) {
          loginIndicator.close(context);
          AutoRouter.of(context).replaceAll(const [HomeRoute()]);
        } else if (state is LoginFailedLoginState) {
          loginIndicator.close(context);
        }
      });
}
