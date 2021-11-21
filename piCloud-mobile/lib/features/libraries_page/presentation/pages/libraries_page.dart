import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:flutter/material.dart';

class LibrariesPage extends StatefulWidget {
  const LibrariesPage({Key? key}) : super(key: key);

  @override
  _LibrariesPageState createState() => _LibrariesPageState();
}

class _LibrariesPageState extends State<LibrariesPage> {
  final String title = 'Libraries';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(
        title: title,
        actions: const [],
      ),
      drawer: const MainDrawer(),
      body: UnderConstructionInfo(pageName: title),
      bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }
}
