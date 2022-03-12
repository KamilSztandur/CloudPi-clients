import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/dialogs/registered_users_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettingsPanel extends StatefulWidget {
  const UserSettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  _UserSettingsPanelState createState() => _UserSettingsPanelState();
}

class _UserSettingsPanelState extends State<UserSettingsPanel> {
  late UsersService service;

  @override
  void initState() {
    service = UsersService(context.read<Api>(), context.read<AuthManager>());
    super.initState();
  }

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
        Icons.person_add_alt_1,
        size: 25,
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).primaryColorDark,
                    fontSize: 17.5,
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
          const Icon(
            Icons.keyboard_arrow_right,
            size: 22.5,
          )
        ],
      ),
    );

    return _buildRow('Browse all users', viewUsersButton);
  }

  Widget _buildRow(String header, Widget action) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 17.5),
          ),
          action,
        ],
      ),
    );
  }

  void _viewAllUsers() => _showUsers(context);

  void _addNewUser() => AutoRouter.of(context).navigate(
        UserWizardRoute(
          onAddUser: _refresh,
        ),
      );

  void _showUsers(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => RegisteredUsersView(
          onDelete: _refresh,
        ),
      );

  void _refresh() => setState(() {});
}
