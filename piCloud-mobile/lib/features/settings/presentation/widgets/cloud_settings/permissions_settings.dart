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
    //TODO
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
    );
  }
}
