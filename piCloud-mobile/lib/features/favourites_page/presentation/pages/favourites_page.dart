import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(),
      drawer: MainDrawer(),
      body: UnderConstructionInfo(pageName: "Favourites"),
      bottomNavigationBar: PICloudBottomNavigationBar(),
    );
  }
}
