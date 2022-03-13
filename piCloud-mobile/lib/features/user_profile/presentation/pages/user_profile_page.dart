import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/user_profile/presentation/widgets/profile_page_content.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PICloudAppBar(
        title: 'User Profile',
        actions: [],
      ),
      drawer: const MainDrawer(),
      body: ProfilePageContent(
        username: username,
      ),
    );
  }
}
