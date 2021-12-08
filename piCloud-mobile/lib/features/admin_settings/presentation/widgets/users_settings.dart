import 'package:app/features/admin_settings/data/models/user.dart';
import 'package:app/features/admin_settings/data/users_service.dart';
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

  void _viewAllUsers() {
    showUsers(context);
  }

  void _addNewUser() {
    //TODO
  }

  void showUsers(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => RegisteredUsersView(),
      );
}

class RegisteredUsersView extends StatelessWidget {
  RegisteredUsersView({
    Key? key,
  }) : super(key: key);

  final UsersService service = UsersService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Registered Users',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildUsersList(context)],
      ),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 15,
      ),
      actions: [
        ElevatedButton(
          onPressed: AutoRouter.of(context).pop,
          style: ElevatedButton.styleFrom(
            primary: Colors.black.withOpacity(
              0.65,
            ),
          ),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildUsersList(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.7;

    return Container(
      height: size * 1.2,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: FutureBuilder(
        future: service.getAllRegisteredUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data! as List<User>;

            return Scrollbar(
              isAlwaysShown: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage:
                          Image.asset('assets/profilepic.jpg').image,
                    ),
                    title: Text(user.nickname),
                    subtitle: Text(_getAccountTypeSubtlitle(user.accountType)),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  String _getAccountTypeSubtlitle(AccountType type) {
    var text = type.toString();
    text = text.substring(text.indexOf('.') + 1, text.length);
    text = text[0].toUpperCase() + text.substring(1, text.length);

    return text;
  }
}
