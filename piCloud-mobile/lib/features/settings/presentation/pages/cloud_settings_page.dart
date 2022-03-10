import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/permissions_settings.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/users_settings.dart';
import 'package:app/features/settings/presentation/widgets/setting_panel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/src/provider.dart';

class CloudSettingsPage extends StatefulWidget {
  const CloudSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  _CloudSettingsPageState createState() => _CloudSettingsPageState();
}

class _CloudSettingsPageState extends State<CloudSettingsPage> {
  final String title = 'Cloud Settings';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkIfUserIsAdmin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: PICloudAppBar(
              title: title,
              actions: const [],
            ),
            body: snapshot.data! as bool
                ? SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _getPanels(),
                    ),
                  )
                : const Center(
                    child: SizedBox(
                      width: 320,
                      child: Text(
                        'Only administrators can use Cloud Settings panel.',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<Widget> _getPanels() {
    final panels = <Widget>[
      const SettingsPanel(
        header: 'Users',
        icon: MdiIcons.accountGroupOutline,
        subPanel: UserSettingsPanel(),
      ),
      const SettingsPanel(
        header: 'Permissions',
        icon: Icons.policy_outlined,
        subPanel: PermissionsSettingsPanel(),
      ),
    ];

    return panels;
  }

  Future<bool> _checkIfUserIsAdmin() async {
    final authManager = context.read<AuthManager>();
    final username = await authManager.getUsernameOfLoggedUser();
    final service = UsersService(context.read<Api>(), authManager);
    return service.checkIfUserIsAdmin(username!);
  }
}
