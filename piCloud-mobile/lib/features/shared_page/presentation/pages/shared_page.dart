import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:flutter/material.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({
    Key? key,
  }) : super(key: key);

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  final String title = 'Shared';

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
