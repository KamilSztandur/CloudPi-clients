class UserProfileData {
  const UserProfileData({
    required this.username,
    required this.nickname,
    required this.email,
    required this.rolesString,
  });

  final String username;
  final String nickname;
  final String email;
  final String rolesString;
}
