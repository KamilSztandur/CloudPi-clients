import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/log_in/bloc/login_bloc.dart';
import 'package:app/features/log_in/data/login_service.dart';
import 'package:app/features/log_in/presentation/widgets/login_button.dart';
import 'package:app/features/log_in/presentation/widgets/password_input_field.dart';
import 'package:app/features/log_in/presentation/widgets/username_input_field.dart';
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
  late LoginBloc _bloc;
  String? username;
  String? password;

  @override
  void initState() {
    _bloc = LoginBloc();
    loginIndicator = LoginProgressIndicator();
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
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UsernameInputField(
                        onChanged: (value) => username = value,
                      ),
                      const SizedBox(height: 10),
                      PasswordInputField(
                        onPasswordChanged: (value) => password = value,
                      ),
                      _getLoginMessageIfAny(state),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              actions: [LoginButton(onPressed: _onLoginPressed)],
            );
          },
        ),
      ),
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
            password: password ?? '',
            username: username ?? '',
          ),
        );
      });

  void _blocListener(BuildContext context, LoginState state) => setState(() {
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
