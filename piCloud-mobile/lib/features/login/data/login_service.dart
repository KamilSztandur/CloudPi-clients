class LoginService {
  static const mockUsername = 'admin';
  static const mockPassword = 'admin1';

  //TODO
  Future<bool> logIn(String username, String password) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (username == mockUsername && password == mockPassword) {
      return true;
    } else {
      return false;
    }
  }
}
