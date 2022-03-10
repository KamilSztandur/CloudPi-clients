import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:app/features/settings/data/user_services/display_service.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class DisplaySettings extends StatefulWidget {
  const DisplaySettings({
    Key? key,
  }) : super(key: key);

  @override
  _DisplaySettingsState createState() => _DisplaySettingsState();
}

class _DisplaySettingsState extends State<DisplaySettings> {
  late DisplayService service;

  @override
  void initState() {
    service = DisplayService(
      preferences: context.read<AppSharedPreferences>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Column(
        children: [
          _buildThemeSwitchRow(),
        ],
      ),
    );
  }

  Widget _buildThemeSwitchRow() {
    final isOn = service.isDarkModeEnabled();
    print("Jest $isOn");

    final themeSwitchButton = Switch(
      onChanged: (value) async {
        setState(() {
          PICloudApp.of(context)!.switchTheme();
        });
      },
      value: isOn,
    );

    return _buildRow('Dark theme', themeSwitchButton);
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
}
