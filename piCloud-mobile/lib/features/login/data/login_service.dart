import 'package:app/common/auth/auth_manager.dart';

class LoginService {
  const LoginService(this._authManager);

  final AuthManager _authManager;
  Future<bool> logIn(String username, String password) async {
    await _authManager.login(
      username: username,
      password: password,
    );

    return _authManager.loggedIn.value;
  }

  Future<bool> isLoggedIn() async {
    const maxAttemptsAmount = 1000;

    for (var i = 0; i < maxAttemptsAmount; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (_authManager.loggedIn.hasValue) {
        return _authManager.loggedIn.value;
      }
    }

    return false;
  }
}
