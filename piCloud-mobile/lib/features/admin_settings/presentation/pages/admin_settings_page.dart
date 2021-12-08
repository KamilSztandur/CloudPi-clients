import 'package:app/features/admin_settings/presentation/widgets/panels/memory_settings.dart';
import 'package:app/features/admin_settings/presentation/widgets/panels/misc_settings.dart';
import 'package:app/features/admin_settings/presentation/widgets/panels/permissions_settings.dart';
import 'package:app/features/admin_settings/presentation/widgets/panels/users_settings.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  _AdminSettingsPageState createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final String title = 'Cloud settings';
  final ScrollController _scrollController = ScrollController();
  final List<bool> expands = [false, false, false, false];

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
      _buildPanel(
        'Users',
        MdiIcons.accountGroupOutline,
        const UserSettingsPanel(),
        0,
      ),
      _buildPanel(
        'Permissions',
        Icons.policy_outlined,
        const PermissionsSettingsPanel(),
        1,
      ),
      _buildPanel(
        'Memory allocation',
        Icons.memory_outlined,
        const MemorySettingsPanel(),
        2,
      ),
      _buildPanel(
        'Miscellaneous',
        Icons.settings_outlined,
        const MiscSettingsPanel(),
        3,
      ),
    ];

    return panels;
  }

  Widget _buildPanel(String header, IconData icon, Widget subPanel, int index) {
    final panel = ExpansionPanel(
      headerBuilder: (context, isExpanded) => _buildHeader(header, icon),
      body: subPanel,
      isExpanded: expands[index],
      canTapOnHeader: true,
    );

    final wrappedPanel = Dialog(
      elevation: 2,
      insetPadding: const EdgeInsets.all(10),
      child: ExpansionPanelList(
        children: [panel],
        expansionCallback: (panelIndex, value) {
          setState(() {
            expands[index] = !expands[index];
          });
        },
      ),
    );

    return wrappedPanel;
  }

  Widget _buildHeader(String header, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 17.5),
          Icon(
            icon,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Text(
            header,
            style: const TextStyle(
              fontSize: 17.5,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
