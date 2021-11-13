import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PICloudBottomNavigationBarItem extends BottomNavigationBarItem {
  final String label;
  final Icon icon;
  final PageRouteInfo route;

  PICloudBottomNavigationBarItem({
    required this.icon,
    required this.label,
    required this.route,
  }) : super(icon: icon, label: label);
}
