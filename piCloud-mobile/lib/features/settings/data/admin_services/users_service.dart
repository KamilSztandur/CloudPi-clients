import 'package:app/common/core/config.dart';
import 'package:app/features/user_wizard/data/models/user.dart';

class UsersService {
  Future<int> getRegisteredUsersAmount() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO

    return _getMockedUsers().length;
  }

  Future<List<User>> getAllRegisteredUsers() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO

    return _getMockedUsers();
  }

  Future<bool> deleteUser(String username) async {
    //TODO

    return true;
  }

  Future<bool> addUser(User user) async {
    //TODO

    return true;
  }

  Future<bool> editUser(User user) async {
    //TODO
    return true;
  }

  String? getWarningMessageForUserData(User user) {
    final allValuesFilled = user.nickname.isNotEmpty &&
        user.username.isNotEmpty &&
        user.password.isNotEmpty &&
        user.allocatedMemoryInMb > 0 &&
        user.email!.isNotEmpty;

    if (allValuesFilled) {
      final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');
      final alphanumericAndSpacePattern = RegExp(r'^[a-zA-Z0-9 ]+$');
      final passwordPattern = RegExp(r'^[a-zA-Z0-9!@#\$%\^&_\-?]+$');
      final emailPattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

      if (!alphanumericPattern.hasMatch(user.username)) {
        return 'Invalid username.';
      }

      if (!alphanumericAndSpacePattern.hasMatch(user.nickname)) {
        return 'Invalid nickname.';
      }

      if (!passwordPattern.hasMatch(user.password)) {
        return 'Invalid password.';
      }

      if (user.password.length < Config.minPasswordLength) {
        return "Pasword's too short (min. 6 characters).";
      }

      if (!emailPattern.hasMatch(user.email!)) {
        return 'Invalid email.';
      }

      return null;
    } else {
      return 'Fill all required fields.';
    }
  }

  // To be removed
  List<User> _getMockedUsers() {
    final mockedUsers = <User>[
      User(
        nickname: 'jankowalski',
        username: 'Jan Kowalski',
        password: '123456',
        accountType: AccountType.user,
        email: null,
        allocatedMemoryInMb: 1000,
      ),
      User(
        nickname: 'kubakowalski',
        username: 'Kuba Kowalski',
        password: '111111',
        accountType: AccountType.user,
        email: null,
        allocatedMemoryInMb: 2048,
      ),
      User(
        nickname: 'harry29',
        username: 'Harry Potter',
        password: '222222',
        accountType: AccountType.admin,
        email: null,
        allocatedMemoryInMb: 1024,
      ),
      User(
        nickname: 'mojlaptoppc',
        username: 'Kamil laptop',
        password: '111',
        accountType: AccountType.user,
        email: null,
        allocatedMemoryInMb: 1024,
      ),
    ];

    return mockedUsers;
  }
}
