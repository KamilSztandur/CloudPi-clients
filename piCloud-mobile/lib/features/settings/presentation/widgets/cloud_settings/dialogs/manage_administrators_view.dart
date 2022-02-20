import 'package:app/contracts/client_index.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/user_wizard/data/models/user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ManageAdministratorsView extends StatefulWidget {
  const ManageAdministratorsView({
    Key? key,
  }) : super(key: key);

  @override
  _ManageAdministratorsViewState createState() =>
      _ManageAdministratorsViewState();
}

class _ManageAdministratorsViewState extends State<ManageAdministratorsView> {
  late UsersService service;
  Map<String, bool>? _permissionsDictionary;

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
        'Manage administrators',
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
          onPressed: _onSubmitPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.withOpacity(
              0.65,
            ),
          ),
          child: const Text('Submit'),
        ),
        OutlinedButton(
          onPressed: _onCancelPressed,
          style: OutlinedButton.styleFrom(
            primary: Colors.black.withOpacity(
              0.65,
            ),
          ),
          child: const Text('Cancel'),
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
        future: _initializeAdminsDictionary(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildList();
          } else {
            return _loadingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildList() {
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _permissionsDictionary!.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildListHeader();
          }

          final username = _permissionsDictionary!.keys.elementAt(index);
          final isChecked = _permissionsDictionary![username];

          return ListTile(
            title: Text(username),
            trailing: _buildCheckBox(username, isChecked),
          );
        },
      ),
    );
  }

  Widget _buildListHeader() {
    return const ListTile(
      title: Text(
        'Username',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.5,
        ),
      ),
      trailing: Text(
        'Is admin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.5,
        ),
      ),
    );
  }

  Widget _buildCheckBox(String username, bool? value) {
    return Checkbox(
      onChanged: (value) => setState(() {
        final currentValue = _permissionsDictionary![username] ?? false;
        _permissionsDictionary![username] = !currentValue;
      }),
      value: value,
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

  void _onCancelPressed() => AutoRouter.of(context).pop();

  void _onSubmitPressed() {
    //TODO
  }

  bool _isAdmin(User user) => user.accountType == AccountType.admin;

  Future<Map<String, bool>> _initializeAdminsDictionary() async {
    if (_permissionsDictionary == null) {
      _permissionsDictionary = <String, bool>{};

      final users = await service.getAllRegisteredUsers();

      for (final user in users) {
        final username = user.nickname;
        final isAdmin = _isAdmin(user);

        _permissionsDictionary![username] = isAdmin;
      }
    }

    return _permissionsDictionary!;
  }
}
