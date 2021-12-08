import 'package:app/features/admin_settings/data/models/user.dart';

class UsersService {
  Future<int> getRegisteredUsersAmount() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO

    return 5;
  }

  Future<List<User>> getAllRegisteredUsers() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO

    return _getMockedUsers();
  }

  Future<bool> deleteUser() async {
    //TODO

    return true;
  }

  Future<bool> addUser() async {
    //TODO

    return true;
  }

  List<User> _getMockedUsers() {
    final mockedUsers = <User>[
      User(
        nickname: 'Adam44',
        username: 'Kamil Sztandur',
        password: '111',
        accountType: AccountType.user,
        email: null,
      ),
      User(
        nickname: 'JurijOwsienko',
        username: 'Jurij Owsianko',
        password: '111',
        accountType: AccountType.user,
        email: null,
      ),
      User(
        nickname: 'harry29',
        username: 'Harry Potter',
        password: '111',
        accountType: AccountType.admin,
        email: null,
      ),
      User(
        nickname: 'mojlaptoppc',
        username: 'Kamil laptop',
        password: '111',
        accountType: AccountType.user,
        email: null,
      ),
    ];

    return mockedUsers;
  }
}
