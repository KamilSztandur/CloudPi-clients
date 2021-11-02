import 'package:app/features/app/widgets/app_bar/app_bar_actions.dart';
import 'package:app/features/app/widgets/app_bar/app_bar_title.dart';
import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PICloudAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  PICloudAppBar({
    required this.height,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppBarTitle(height: this.height),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        AppBarSearchButton(),
        SwitchFileExplorerView(),
        UserProfileImage(size: this.height * 0.5),
      ],
    );
  }
}
