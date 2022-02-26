import 'package:flutter/material.dart';

class User {
  User({
    required this.nickname,
    required this.username,
    required this.password,
    required this.accountType,
    required this.email,
    required this.allocatedMemoryInMb,
    this.profilePic,
  });

  String nickname;
  String username;
  String password;
  AccountType accountType;
  String? email;
  MemoryImage? profilePic;
  double allocatedMemoryInMb;
}

enum AccountType { user, admin, moderator, bot }
