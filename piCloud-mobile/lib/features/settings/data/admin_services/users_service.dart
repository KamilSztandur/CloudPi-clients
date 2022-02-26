import 'package:app/common/core/config.dart';
import 'package:app/contracts/api.enums.swagger.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/user_wizard/data/models/user.dart';

class UsersService {
  const UsersService(this._api);

  final Api _api;

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

    if (response.isSuccessful) {
      final allocationResponse = await _api.filesystemUsernamePost(
        username: user.username,
        newAssignedSpace: user.allocatedMemoryInMb.toInt(),
      );

      /*
      if (user.profilePic != null) {
        final postImageResponse = await _api.filesImagePost(
          body: FilesImagePost$RequestBody(
            file: String.fromCharCodes(user.profilePic!.bytes),
          ),
        );

        final attachImageToUserResponse = await _api.userUsernamePatch(
          username: user.username,
          body: PatchUserRequest(
            profilePicturePubId: postImageResponse.body!.pubId,
          ),
        );

        return allocationResponse.isSuccessful &&
            postImageResponse.isSuccessful &&
            attachImageToUserResponse.isSuccessful;
      }
      */
      return allocationResponse.isSuccessful;
    } else {
      return false;
    }
  }

  Future<bool> editUser(User user) async {
    final response = await _api.userUsernamePatch(
      username: user.username,
      body: PatchUserRequest(
        email: user.email,
        nickname: user.nickname,
      ),
    );

    final memoryAllocationResponse = await _api.filesystemUsernamePost(
      username: user.username,
      newAssignedSpace: user.allocatedMemoryInMb.toInt(),
    );

    return response.isSuccessful && memoryAllocationResponse.isSuccessful;
  }

  String? getWarningMessageForUserData(User user, bool creatingNewUser) {
    final allValuesWithoutPasswordFilled = user.nickname.isNotEmpty &&
        user.username.isNotEmpty &&
        user.allocatedMemoryInMb > 0 &&
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
}
