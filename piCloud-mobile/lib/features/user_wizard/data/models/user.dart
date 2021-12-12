import 'package:flutter/material.dart';

class User {
  User({
    required this.nickname,
    required this.username,
    required this.password,
    required this.accountType,
    required this.email,
    required this.allocatedMemoryInMb,
  });

  String nickname;
  String username;
  String password;
  AccountType accountType;
  String? email;
  Image? profilePic;
  double allocatedMemoryInMb;
}

enum AccountType { user, admin, service }
