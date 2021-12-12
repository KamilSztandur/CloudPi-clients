import 'package:app/common/core/config.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/create_new_user/data/models/user.dart';
import 'package:app/features/create_new_user/presentation/widgets/input_field.dart';
import 'package:app/features/create_new_user/presentation/widgets/memory_allocation_input.dart';
import 'package:app/features/create_new_user/presentation/widgets/password_input_field.dart';
import 'package:app/features/create_new_user/presentation/widgets/user_avatar_input.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateNewUserPage extends StatefulWidget {
  const CreateNewUserPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  _CreateNewUserPageState createState() => _CreateNewUserPageState();
}

class _CreateNewUserPageState extends State<CreateNewUserPage> {
  final ScrollController _scrollController = ScrollController();
  late User user;

  @override
  void initState() {
    if (widget.user == null) {
      user = User(
        nickname: '',
        username: '',
        password: '',
        accountType: AccountType.user,
        email: '',
        allocatedMemoryInMb: 0,
      );
    } else {
      user = User(
        nickname: widget.user!.nickname,
        username: widget.user!.username,
        password: widget.user!.password,
        accountType: widget.user!.accountType,
        email: widget.user!.email,
        allocatedMemoryInMb: widget.user!.allocatedMemoryInMb,
      );
    }

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
                    hintText: 'johnsmith',
                    onChanged: _onUsernameChanged,
                    initialValue: user.username,
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
              hintText: 'John Smith',
              onChanged: _onNicknameChanged,
              initialValue: user.nickname,
            ),
            const SizedBox(height: 10),
            InputFieldPassword(
              headerText: 'Password',
              hintTexti: 'At least 8 Charecter',
              onPasswordChanged: _onPasswordChanged,
              initialValue: user.password,
            ),
            const SizedBox(height: 10),
            InputField(
              headerText: 'Email',
              hintText: 'john@smith.eu',
              onChanged: _onEmailChanged,
              initialValue: user.email,
            ),
            const SizedBox(height: 10),
            MemoryAllocationInput(
              defaultValue: user.allocatedMemoryInMb,
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
      if (_isThisNewUserCreation()) {
        //TODO
      } else {
        //TODO
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  bool _isThisNewUserCreation() => widget.user == null;

  String? _getWarningMessageForUserData() {
    final allValuesFilled = user.nickname.isNotEmpty &&
        user.username.isNotEmpty &&
        user.password.isNotEmpty &&
        user.allocatedMemoryInMb > 0 &&
        user.email!.isNotEmpty;

    if (allValuesFilled) {
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

      if (!passwordPattern.hasMatch(user.password)) {
        return 'Invalid password.';
      }

      if (user.password.length < Config.minPasswordLength) {
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
