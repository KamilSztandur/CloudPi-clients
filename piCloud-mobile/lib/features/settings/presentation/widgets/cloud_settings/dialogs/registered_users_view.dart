import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/dialogs/submit_user_delete.dart';
import 'package:app/features/user_wizard/data/models/user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class RegisteredUsersView extends StatefulWidget {
  const RegisteredUsersView({
    Key? key,
  }) : super(key: key);

  @override
  _RegisteredUsersViewState createState() => _RegisteredUsersViewState();
}

class _RegisteredUsersViewState extends State<RegisteredUsersView> {
  late UsersService service;

  @override
  void initState() {
    service = UsersService(context.read<Api>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text(
        'Registered Users',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildUsersList()],
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

  Widget _buildUsersList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.85,
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
        itemBuilder: (context, index) => _buildTile(users[index]),
      ),
    );
  }

  Widget _buildTile(User user) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage:
            user.profilePic ?? Image.asset('assets/profilepic.jpg').image,
      ),
      title: Text(user.nickname),
      subtitle: Text(_getAccountTypeSubtlitle(user.accountType)),
      trailing: _buildOptionsMenu(user),
    );
  }

  Widget _buildOptionsMenu(User user) {
    return PopupMenuButton<String>(
      onSelected: (result) => _onOptionSelected(result, user),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            children: const [
              Icon(Icons.edit_outlined),
              SizedBox(width: 10),
              Text('Edit'),
              SizedBox(width: 30),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: Row(
            children: const [
              Icon(Icons.delete_outline),
              SizedBox(width: 10),
              Text('Delete'),
              SizedBox(width: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Info',
          child: Row(
            children: const [
              Icon(Icons.info_outline),
              SizedBox(width: 10),
              Text('Info'),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  void _onOptionSelected(String value, User user) {
    AutoRouter.of(context).pop();

    switch (value) {
      case 'Edit':
        _onEditPressed(user);
        break;

      case 'Delete':
        _onDeletePressed(user);
        break;

      case 'Info':
        _onInfoPressed(user);
        break;

      default:
      //Do Nothing
    }
  }

  void _onEditPressed(User user) =>
      AutoRouter.of(context).navigate(UserWizardRoute(user: user));

  void _onDeletePressed(User user) => Future<void>.delayed(
        // Do not remove Future. Showdialog needs time.
        Duration.zero,
        () => showDialog<void>(
          context: context,
          builder: (context) => DeleteUserView(user: user),
        ),
      );

  void _onInfoPressed(User user) {
    //TODO
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
