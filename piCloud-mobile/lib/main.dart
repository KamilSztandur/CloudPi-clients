import 'package:flutter/material.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  _setUpSharedPrefs();

  runApp(PICloudApp());
}

void _setUpSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("preferredView", "tiles");
}
