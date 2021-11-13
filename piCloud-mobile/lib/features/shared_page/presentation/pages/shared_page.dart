import 'package:flutter/material.dart';
import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';

class SharedPage extends StatefulWidget {
  SharedPage({
    Key? key,
  }) : super(key: key);

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(),
      body: UnderConstructionInfo(pageName: "Shared"),
      bottomNavigationBar: PICloudBottomNavigationBar(),
    );
  }
}
