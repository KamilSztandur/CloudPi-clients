import 'package:app/features/create_new_user/data/models/user.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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

            return _buildList(users);
          } else {
            return _loadingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildList(List<User> users) {
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            leading: CircleAvatar(
              foregroundImage: Image.asset('assets/profilepic.jpg').image,
            ),
            title: Text(user.nickname),
            subtitle: Text(_getAccountTypeSubtlitle(user.accountType)),
          );
        },
      ),
    );
  }

  Widget _loadingIndicator() {
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

  String _getAccountTypeSubtlitle(AccountType type) {
    var text = type.toString();
    text = text.substring(text.indexOf('.') + 1, text.length);
    text = text[0].toUpperCase() + text.substring(1, text.length);

    return text;
  }
}
