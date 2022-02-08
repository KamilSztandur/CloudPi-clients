import 'package:flutter/material.dart';

class MemorySettingsPanel extends StatefulWidget {
  const MemorySettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  _MemorySettingsPanelState createState() => _MemorySettingsPanelState();
}

class _MemorySettingsPanelState extends State<MemorySettingsPanel> {
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
