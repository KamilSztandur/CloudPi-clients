import 'dart:ffi';

import 'dart:typed_data';

class UserProfileData {
  const UserProfileData({
    required this.username,
    required this.nickname,
    required this.email,
    required this.typeOfAccount,
  });

  final String username;
  final String nickname;
  final String email;
  final String typeOfAccount;
}
