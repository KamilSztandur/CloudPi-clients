import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PICloudBottomNavigationBarItem extends BottomNavigationBarItem {
  PICloudBottomNavigationBarItem({
    required Icon icon,
    required String label,
    required this.route,
  }) : super(
          icon: icon,
          label: label,
        );

  final PageRouteInfo route;
}
