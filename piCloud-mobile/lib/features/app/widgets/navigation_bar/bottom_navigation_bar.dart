import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PICloudBottomNavigationBar extends StatefulWidget {
  final Function(PageRouteInfo) pageSwitched;

  PICloudBottomNavigationBar({
    Key? key,
    required this.pageSwitched,
  }) : super(key: key);

  @override
  _PICloudBottomNavigationBar createState() => _PICloudBottomNavigationBar();
}

class _PICloudBottomNavigationBar extends State<PICloudBottomNavigationBar> {
  final List<PICloudBottomNavigationBarItem> items =
      <PICloudBottomNavigationBarItem>[
    PICloudBottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      route: HomeRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: Icon(Icons.folder_outlined),
      label: 'Files',
      route: FileExplorerRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: Icon(Icons.folder_shared_outlined),
      label: 'Shared',
      route: SharedRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      label: 'Libraries',
      route: LibrariesRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: Icon(Icons.star_outline),
      label: 'Favourites',
      route: FavouritesRoute(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _getCurrentlySelectedItem(),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: this.items,
      ),
    );
  }

  int _getCurrentlySelectedItem() {
    var currentRoute = AutoRouter.of(context).current.route.toRoute().routeName;

    int n = items.length;
    for (int i = 0; i < n; i++) {
      if (items[i].route.routeName == currentRoute) {
        return i;
      }
    }

    return -1;
  }

  void _onItemTapped(int index) {
    AutoRouter.of(context).navigate(items[index].route);
    //this.widget.pageSwitched(items[index].route);
  }
}
