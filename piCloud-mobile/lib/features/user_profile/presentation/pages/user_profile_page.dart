import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/user_profile/presentation/widgets/profile_page_content.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PICloudAppBar(
        title: 'User Profile',
        actions: [],
      ),
      drawer: MainDrawer(),
      body: ProfilePageContent(),
    );
  }
}
