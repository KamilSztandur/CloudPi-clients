import 'package:flutter/material.dart';

class MiscSettingsPanel extends StatefulWidget {
  const MiscSettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  _MiscSettingsPanelState createState() => _MiscSettingsPanelState();
}

class _MiscSettingsPanelState extends State<MiscSettingsPanel> {
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
