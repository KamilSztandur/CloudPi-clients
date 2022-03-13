import 'package:app/features/settings/presentation/widgets/cloud_settings/dialogs/manage_administrators_view.dart';
import 'package:flutter/material.dart';

class PermissionsSettingsPanel extends StatefulWidget {
  const PermissionsSettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  _PermissionsSettingsPanelState createState() =>
      _PermissionsSettingsPanelState();
}

class _PermissionsSettingsPanelState extends State<PermissionsSettingsPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Column(
        children: [
          _buildManageAdministratorsRow(),
        ],
      ),
    );
  }

  Widget _buildManageAdministratorsRow() {
    final addUserButton = GestureDetector(
      onTap: _manageAdministrators,
      child: const Icon(
        Icons.edit,
        size: 25,
      ),
    );

    return _buildRow('Manage administrators', addUserButton);
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

  void _manageAdministrators() => showDialog<void>(
        context: context,
        builder: (context) => const ManageAdministratorsView(),
      );
}
