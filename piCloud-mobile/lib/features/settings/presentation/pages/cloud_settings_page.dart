import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/memory_settings.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/misc_settings.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/permissions_settings.dart';
import 'package:app/features/settings/presentation/widgets/cloud_settings/users_settings.dart';
import 'package:app/features/settings/presentation/widgets/setting_panel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    return Scaffold(
      appBar: PICloudAppBar(
        title: title,
        actions: const [],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getPanels(),
        ),
      ),
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
      const SettingsPanel(
        header: 'Memory allocation',
        icon: Icons.memory_outlined,
        subPanel: MemorySettingsPanel(),
      ),
      const SettingsPanel(
        header: 'Miscellaneous',
        icon: Icons.settings_outlined,
        subPanel: MiscSettingsPanel(),
      ),
    ];

    return panels;
  }
}
