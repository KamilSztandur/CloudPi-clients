import 'package:flutter/material.dart';

class PICloudAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  PICloudAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title ?? ""),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
