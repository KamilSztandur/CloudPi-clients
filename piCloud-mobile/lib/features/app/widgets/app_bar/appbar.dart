import 'package:app/features/app/widgets/app_bar/go_back_leading.dart';
import 'package:auto_route/auto_route.dart';
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
      title: Text(
        this.title ?? "",
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: _shouldDisplayGoBackLeading(context) ? GoBackLeading() : null,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  bool _shouldDisplayGoBackLeading(BuildContext context) =>
      AutoRouter.of(context).stack.length > 1;
}
