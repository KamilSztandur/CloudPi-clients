import 'package:flutter/material.dart';
import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';

class LibrariesPage extends StatefulWidget {
  LibrariesPage({
    Key? key,
  }) : super(key: key);

  @override
  _LibrariesPageState createState() => _LibrariesPageState();
}

class _LibrariesPageState extends State<LibrariesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(),
      body: UnderConstructionInfo(pageName: "Libraries"),
      bottomNavigationBar: PICloudBottomNavigationBar(
        pageSwitched: (PageRouteInfo<dynamic> route) =>
            AutoRouter.of(context).navigate(route),
      ),
    );
  }
}
