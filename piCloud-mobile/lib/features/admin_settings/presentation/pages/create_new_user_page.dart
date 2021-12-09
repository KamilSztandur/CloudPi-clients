import 'package:app/features/admin_settings/data/models/user.dart';
import 'package:app/features/admin_settings/presentation/widgets/user_wizard/input_field.dart';
import 'package:app/features/admin_settings/presentation/widgets/user_wizard/memory_allocation_input.dart';
import 'package:app/features/admin_settings/presentation/widgets/user_wizard/password_input_field.dart';
import 'package:app/features/admin_settings/presentation/widgets/user_wizard/user_avatar_input.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateNewUserPage extends StatefulWidget {
  const CreateNewUserPage({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewUserPageState createState() => _CreateNewUserPageState();
}

class _CreateNewUserPageState extends State<CreateNewUserPage> {
  final ScrollController _scrollController = ScrollController();
  late User user;

  @override
  void initState() {
    user = User(
      nickname: '',
      username: '',
      password: '',
      accountType: AccountType.user,
      email: '',
      allocatedMemoryInMb: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PICloudAppBar(
        title: 'New user wizard',
        actions: [],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: InputField(
                    headerText: 'Username',
                    hintText: 'Username',
                    onChanged: _onUsernameChanged,
                  ),
                ),
                Container(
                  height: 75,
                  padding: const EdgeInsets.only(right: 20),
                  child: UserAvatarInput(
                    imagePicked: _onUserAvatarChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            InputField(
              headerText: 'Nickname',
              hintText: 'Nickname',
              onChanged: _onNicknameChanged,
            ),
            const SizedBox(height: 10),
            InputFieldPassword(
              headerText: 'Password',
              hintTexti: 'At least 8 Charecter',
              onPasswordChanged: _onPasswordChanged,
            ),
            const SizedBox(height: 10),
            InputField(
              headerText: 'Email',
              hintText: 'jan@kowalski.com',
              onChanged: _onEmailChanged,
            ),
            const SizedBox(height: 10),
            MemoryAllocationInput(
              defaultValue: 1024,
              maxValue: 10240,
              headerText: 'Memory allocation',
              onValueChanged: _onMemoryAllocationChanged,
            ),
            const SizedBox(height: 25),
            _getCreateButton(),
            const SizedBox(height: 10),
            _buildCancelButton(),
          ],
        ),
      ),
    );
  }

  Widget _getCreateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onCreatePressed,
          child: const Text(
            'Create',
            style: TextStyle(
              fontSize: 22.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: _onCancelPressed,
          style: TextButton.styleFrom(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 22.5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void _onNicknameChanged(String value) => user.nickname = value;

  void _onUsernameChanged(String value) => user.username = value;

  void _onPasswordChanged(String value) => user.password = value;

  void _onEmailChanged(String value) => user.email = value;

  void _onUserAvatarChanged(Image value) => user.profilePic = value;

  void _onMemoryAllocationChanged(double value) =>
      user.allocatedMemoryInMb = value;

  void _onCancelPressed() => AutoRouter.of(context).pop();

  void _onCreatePressed() {
    final errorMessage = _getWarningMessageForUserData();

    if (errorMessage == null) {
      //TODO
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  String? _getWarningMessageForUserData() {
    final allValuesFilled = user.nickname.isNotEmpty &&
        user.username.isNotEmpty &&
        user.password.isNotEmpty &&
        user.allocatedMemoryInMb > 0 &&
        user.email!.isNotEmpty;

    if (allValuesFilled) {
      final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');
      final alphanumericAndSpacePattern = RegExp(r'^[a-zA-Z0-9 ]+$');
      final passwordPattern = RegExp(r'^[a-zA-Z0-9!@#\$%\^&]+$');
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

      if (!emailPattern.hasMatch(user.email!)) {
        return 'Invalid email.';
      }

      return null;
    } else {
      return 'Fill all required fields.';
    }
  }
}
