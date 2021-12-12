import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/dialogs/registered_users_view.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

class UserSettingsPanel extends StatefulWidget {
  const UserSettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  _UserSettingsPanelState createState() => _UserSettingsPanelState();
}

class _UserSettingsPanelState extends State<UserSettingsPanel> {
  final UsersService service = UsersService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Column(
        children: [
          _buildAllUsersRow(),
          _buildAddUserRow(),
        ],
      ),
    );
  }

  Widget _buildAddUserRow() {
    final addUserButton = GestureDetector(
      onTap: _addNewUser,
      child: const Icon(
        Icons.person_add_alt_1_outlined,
      ),
    );

    return _buildRow('Add new user', addUserButton);
  }

  Widget _buildAllUsersRow() {
    final viewUsersButton = GestureDetector(
      onTap: _viewAllUsers,
      child: Row(
        children: [
          FutureBuilder(
            future: service.getRegisteredUsersAmount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final amount = snapshot.data! as int;

                return Text(
                  '$amount',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
          ),
          const Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );

    return _buildRow('All users', viewUsersButton);
  }

  Widget _buildRow(String header, Widget action) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 15),
          ),
          action,
        ],
      ),
    );
  }

  void _viewAllUsers() => showUsers(context);

  void _addNewUser() => AutoRouter.of(context).navigate(UserWizardRoute());

  void showUsers(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => const RegisteredUsersView(),
      );
}
