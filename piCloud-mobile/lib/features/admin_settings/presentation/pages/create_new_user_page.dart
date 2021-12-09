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
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PICloudAppBar(
        title: 'New user wizard',
        actions: [],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(
                  child: InputField(
                    headerText: 'Username',
                    hintTexti: 'Username',
                  ),
                ),
                Container(
                  height: 75,
                  padding: const EdgeInsets.only(right: 20),
                  child: UserAvatarInput(imagePicked: _imagePicked),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const InputField(
              headerText: 'Nickname',
              hintTexti: 'Nickname',
            ),
            const SizedBox(height: 10),
            const InputFieldPassword(
              headerText: 'Password',
              hintTexti: 'At least 8 Charecter',
            ),
            const SizedBox(height: 10),
            const InputField(
              headerText: 'Email',
              hintTexti: 'jan@kowalski.com',
            ),
            const SizedBox(height: 10),
            MemoryAllocationInput(
              defaultValue: 1024,
              maxValue: 10240,
              headerText: 'Memory allocation',
              onValueChanged: (value) {
                //TODO
              },
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

  void _imagePicked(Image image) {
    //TODO
  }

  void _onCreatePressed() {
    //TODO
  }

  void _onCancelPressed() {
    AutoRouter.of(context).pop();
  }
}
