import 'package:app/common/auth/auth_manager.dart';

class LoginService {
  const LoginService(this._authManager);

  final AuthManager _authManager;

  static const mockUsername = 'admin';
  static const mockPassword = 'admin1';

  Future<bool> logIn(String username, String password) async {
    await _authManager.login(
      username: username,
      password: password,
    );

    return _authManager.loggedIn.value;
  }
}
