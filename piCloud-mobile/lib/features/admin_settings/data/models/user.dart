class User {
  User({
    required this.nickname,
    required this.username,
    required this.password,
    required this.accountType,
    required this.email,
  });

  String nickname;
  String username;
  String password;
  AccountType accountType;
  String? email;
}

enum AccountType { user, admin, service }
