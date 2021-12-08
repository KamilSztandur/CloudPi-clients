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
