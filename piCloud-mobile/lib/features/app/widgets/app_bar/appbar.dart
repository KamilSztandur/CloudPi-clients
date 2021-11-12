import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:flutter/material.dart';

class PICloudAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: UserProfileImage(size: kToolbarHeight * 0.8),
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
    );
  }
}
