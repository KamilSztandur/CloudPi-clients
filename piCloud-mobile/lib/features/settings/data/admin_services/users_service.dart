import 'package:app/features/create_new_user/data/models/user.dart';

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
