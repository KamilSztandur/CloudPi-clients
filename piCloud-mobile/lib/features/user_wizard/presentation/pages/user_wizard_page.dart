import 'dart:io';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/user_wizard/data/models/image_wrapper.dart';
import 'package:app/features/user_wizard/data/models/user.dart';
import 'package:app/features/user_wizard/presentation/widgets/input_field.dart';
import 'package:app/features/user_wizard/presentation/widgets/memory_allocation_input.dart';
import 'package:app/features/user_wizard/presentation/widgets/password_input_field.dart';
import 'package:app/features/user_wizard/presentation/widgets/user_avatar_input.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWizardPage extends StatefulWidget {
  const UserWizardPage({
    Key? key,
    this.user,
    this.onAddUser,
  }) : super(key: key);

  final User? user;
  final VoidCallback? onAddUser;

  @override
  _UserWizardPageState createState() => _UserWizardPageState();
}

class _UserWizardPageState extends State<UserWizardPage> {
  final ScrollController _scrollController = ScrollController();
  late UsersService service;
  late User user;

  @override
  void initState() {
    _initializeDefaultUserData();
    service = UsersService(context.read<Api>(), context.read<AuthManager>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(
        title: _isThisNewUserCreation() ? 'Create new user' : 'Edit user',
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
                    isEnabled: _isThisNewUserCreation(),
                  ),
                ),
                Container(
                  height: 75,
                  padding: const EdgeInsets.only(right: 20),
                  child: FutureBuilder(
                    future: service.getCurrentProfilePic(user.username),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final wrappedImage = snapshot.data! as ImageWrapper;
                        return UserAvatarInput(
                          imagePicked: _onUserAvatarChanged,
                          oldImage: _isThisNewUserCreation()
                              ? null
                              : wrappedImage.image,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
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
              isEnabled: true,
            ),
            const SizedBox(height: 10),
            InputFieldPassword(
              headerText: _isThisNewUserCreation()
                  ? 'Password'
                  : 'New Password (or empty)',
              hintTexti: 'At least 8 characters',
              onPasswordChanged: _onPasswordChanged,
            ),
            const SizedBox(height: 10),
            InputField(
              headerText: 'Email',
              hintText: 'john@smith.eu',
              onChanged: _onEmailChanged,
              initialValue: user.email,
              isEnabled: true,
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
          child: Text(
            widget.user == null ? 'Create' : 'Save changes',
            style: const TextStyle(
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

  void _onUserAvatarChanged(File value) => user.profilePic = value;

  void _onMemoryAllocationChanged(double value) =>
      user.allocatedMemoryInMb = value;

  void _onCancelPressed() => AutoRouter.of(context).pop();

  Future<void> _onCreatePressed() async {
    final errorMessage = service.getWarningMessageForUserData(
      user,
      creatingNewUser: _isThisNewUserCreation(),
    );

    if (errorMessage == null) {
      if (_isThisNewUserCreation()) {
        await service.addUser(user);
        final action = widget.onAddUser;

        if (action != null) {
          action();
        }
      } else {
        await service.editUser(user);
      }

      await AutoRouter.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  bool _isThisNewUserCreation() => widget.user == null;

  void _initializeDefaultUserData() {
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
  }
}
