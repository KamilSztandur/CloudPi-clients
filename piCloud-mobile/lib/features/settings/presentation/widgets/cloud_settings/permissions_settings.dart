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
          //TODO
        ],
      ),
    );
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
}
