import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/settings/presentation/widgets/setting_panel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String title = 'Settings';
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
      SettingsPanel(
        header: 'Account',
        icon: MdiIcons.accountOutline,
        subPanel: Container(),
      ),
      SettingsPanel(
        header: 'Notifications',
        icon: MdiIcons.bellOutline,
        subPanel: Container(),
      ),
      SettingsPanel(
        header: 'Appearance',
        icon: MdiIcons.eyeOutline,
        subPanel: Container(),
      ),
      SettingsPanel(
        header: 'Data transfer',
        icon: MdiIcons.cloudDownloadOutline,
        subPanel: Container(),
      ),
      SettingsPanel(
        header: 'Help',
        icon: MdiIcons.helpCircleOutline,
        subPanel: Container(),
      ),
    ];

    return panels;
  }
}
