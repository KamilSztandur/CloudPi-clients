import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PICloudBottomNavigationBar extends StatefulWidget {
  const PICloudBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _PICloudBottomNavigationBar createState() => _PICloudBottomNavigationBar();
}

class _PICloudBottomNavigationBar extends State<PICloudBottomNavigationBar> {
  final List<PICloudBottomNavigationBarItem> items =
      <PICloudBottomNavigationBarItem>[
    PICloudBottomNavigationBarItem(
      icon: const Icon(Icons.folder_outlined),
      label: 'Files',
      route: FileExplorerRoute(path: '/'),
    ),
    PICloudBottomNavigationBarItem(
      icon: const Icon(Icons.folder_shared_outlined),
      label: 'Shared',
      route: const SharedRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: const Icon(Icons.star_outline),
      label: 'Favourites',
      route: const FavouritesRoute(),
    ),
    PICloudBottomNavigationBarItem(
      icon: const Icon(Icons.search_outlined),
      label: 'Search',
      route: SearchRoute(),
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
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _getCurrentlySelectedItem(),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: items,
      ),
    );
  }

  int _getCurrentlySelectedItem() {
    final currentRoute =
        AutoRouter.of(context).current.route.toRoute().routeName;

    final n = items.length;
    for (var i = 0; i < n; i++) {
      if (items[i].route.routeName == currentRoute) {
        return i;
      }
    }

    return 0;
  }

  void _onItemTapped(int index) => AutoRouter.of(context).replaceAll(
        [items[index].route],
      );
}
