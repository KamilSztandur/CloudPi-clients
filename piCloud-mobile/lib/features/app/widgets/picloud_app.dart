import 'package:app/features/app/widgets/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/presentation/pages/file_explorer_page.dart';
import 'package:flutter/material.dart';

class PICloudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICloud App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: PICloudBottomNavigationBar(
          pageSwitched: (int index) {
            //TODO
          },
        ),
        body: FileExplorerPage(),
      ),
    );
  }
}
