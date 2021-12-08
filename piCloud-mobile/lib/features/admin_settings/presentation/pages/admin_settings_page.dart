import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:flutter/material.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  _AdminSettingsPageState createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final String title = 'Admin settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(
        title: title,
        actions: const [],
      ),
      body: Container(),
    );
  }
}
