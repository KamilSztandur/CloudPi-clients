import 'package:app/features/app/widgets/bottom_navigation_bar.dart';
import 'package:app/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class PICloudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICloud App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: PICloudBottomNavigationBar(
          pageSwitched: (int index) {
            //TODO
          },
        ),
        body: UserProfilePage(),
      ),
    );
  }
}
