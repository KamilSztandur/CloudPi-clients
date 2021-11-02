import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class PICloudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICloud App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: Scaffold(
        appBar: PICloudAppBar(height: 50.0),
        body: Container(),
        bottomNavigationBar: PICloudBottomNavigationBar(),
      ),
    );
  }
}
