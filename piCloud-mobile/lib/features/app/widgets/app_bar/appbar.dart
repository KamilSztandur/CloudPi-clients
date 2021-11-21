import 'package:app/features/app/widgets/app_bar/go_back_leading.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PICloudAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PICloudAppBar({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      centerTitle: true,
      leading:
          _shouldDisplayGoBackLeading(context) ? const GoBackLeading() : null,
      backgroundColor: Theme.of(context).primaryColor,
      actions: actions,
    );
  }

  bool _shouldDisplayGoBackLeading(BuildContext context) =>
      AutoRouter.of(context).stack.length > 1;
}
