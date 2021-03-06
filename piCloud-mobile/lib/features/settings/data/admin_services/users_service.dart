import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/contracts/api.enums.swagger.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/user_wizard/data/models/image_wrapper.dart';
import 'package:app/features/user_wizard/data/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UsersService {
  const UsersService(this._api, this._authManager);

  final Api _api;
  final AuthManager _authManager;

  Future<int> getRegisteredUsersAmount() async {
    final response = await _api.userGet();
    return response.body!.length;
  }

  Future<List<User>> getAllRegisteredUsers() async {
    final response = await _api.userGet();
    final allUsers = response.body!;
    final result = <User>[];

    for (final user in allUsers) {
      final username = user.username;
      final nickname = user.nickname;

      final userDetailsResponse =
          await _api.userUsernameDetailsGet(username: username);
      final userDetails = userDetailsResponse.body!;
      final email = userDetails.email;
      AccountType accountType;

      if (userDetails.roles!.contains(UserDetailsDTORoles.admin)) {
        accountType = AccountType.admin;
      } else if (userDetails.roles!.contains(UserDetailsDTORoles.moderator)) {
        accountType = AccountType.moderator;
      } else if (userDetails.roles!.contains(UserDetailsDTORoles.bot)) {
        accountType = AccountType.bot;
      } else {
        accountType = AccountType.user;
      }

      final allocatedMemoryResponse =
          await _api.filesystemUsernameGet(username: username);
      int? allocatedMemory;

      try {
        allocatedMemory = allocatedMemoryResponse.body!.totalSpace;
      } catch (exception) {
        allocatedMemory = 0;
      }

      result.add(
        User(
          accountType: accountType,
          allocatedMemoryInMb: allocatedMemory!.toDouble(),
          email: email,
          nickname: nickname!,
          password: '',
          username: username!,
        ),
      );
    }

    return result;
  }

  Future<bool> deleteUser(String username) async {
    final response = await _api.userUsernameDelete(username: username);
    return response.isSuccessful;
  }

  Future<bool> addUser(User user) async {
    final response = await _api.userNewPost(
      body: PostUserRequest(
        username: user.username,
        nickname: user.nickname,
        email: user.email,
        password: user.password,
      ),
    );

    if (!response.isSuccessful) {
      return false;
    }

    if (user.profilePic != null) {
      final setProfilePicSuccess = await _setProfilePictureOfUser(user);
      return setProfilePicSuccess;
    }

    return true;
  }

  Future<bool> editUser(User user) async {
    final response = await _api.userUsernamePatch(
      username: user.username,
      body: PatchUserRequest(
        email: user.email,
        nickname: user.nickname,
      ),
    );

    if (user.password != '') {
      final changePasswordResponse = await _api.userPasswordPut(
        body: PutUserPasswordRequest(
          username: user.username,
          newPassword: user.password,
        ),
      );

      return response.isSuccessful && changePasswordResponse.isSuccessful;
    }

    if (user.profilePic != null) {
      final changeProfilePicResult = await _setProfilePictureOfUser(user);
      return response.isSuccessful && changeProfilePicResult;
    }

    return response.isSuccessful;
  }

  String? getWarningMessageForUserData(
    User user, {
    required bool creatingNewUser,
  }) {
    final allValuesWithoutPasswordFilled = user.nickname.isNotEmpty &&
        user.username.isNotEmpty &&
        user.email!.isNotEmpty;

    final allValuesFilled =
        allValuesWithoutPasswordFilled && user.password.isNotEmpty;

    if (allValuesFilled ||
        (!creatingNewUser && allValuesWithoutPasswordFilled)) {
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

      if (!passwordPattern.hasMatch(user.password) && creatingNewUser) {
        return 'Invalid password.';
      }

      if (creatingNewUser && user.password.length < Config.minPasswordLength) {
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

  Future<bool> checkIfUserIsAdmin(String username) async {
    final response = await _api.userUsernameDetailsGet(username: username);
    if (response.isSuccessful &&
        response.body!.roles!.contains(UserDetailsDTORoles.admin)) {
      return true;
    }

    return false;
  }

  Future<ImageWrapper> getCurrentProfilePic(String username) async {
    final response = await _api.userProfileImageGet(username: username);

    if (response.isSuccessful) {
      return ImageWrapper(MemoryImage(response.bodyBytes));
    }

    return const ImageWrapper(null);
  }

  Future<bool> _setProfilePictureOfUser(User user) async {
    final authString = 'Bearer ${(await _authManager.getAccessToken())!}';
    final headers = {'Authorization': authString};
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Config.apiBaseUrl}/user/profile-image/${user.username}'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        user.profilePic!.path,
      ),
    );

    request.headers.addAll(headers);
    final response = await request.send();
    return response.statusCode == 200;
  }
}
