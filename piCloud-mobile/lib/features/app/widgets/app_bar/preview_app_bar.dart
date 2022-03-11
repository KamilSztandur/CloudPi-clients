import 'dart:io';

import 'package:app/features/file_explorer/data/selection_icon_button_choice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PreviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PreviewAppBar({
    Key? key,
    required this.resourceName,
    required this.onDownloadRequested,
    required this.onDeleteRequested,
    required this.onRenameRequested,
    required this.onShareRequested,
  }) : super(key: key);

  final String resourceName;
  final VoidCallback onDownloadRequested;
  final VoidCallback onDeleteRequested;
  final VoidCallback onRenameRequested;
  final VoidCallback onShareRequested;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        resourceName,
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      ),
      leading: _buildLeading(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Colors.transparent,
      actions: [
        PopupMenuButton(
          onSelected: _onHamburgerItemPressed,
          icon: Icon(
            Icons.more_vert_rounded,
            color: Theme.of(context).iconTheme.color,
          ),
          itemBuilder: (context) => _getHamburgerMenuBody()
              .map(
                (choice) => PopupMenuItem<SelectionIconButtonChoice>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(
                        choice.icon,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            choice.title!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _buildLeading(BuildContext context) {
    return IconButton(
      onPressed: AutoRouter.of(context).pop,
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).iconTheme.color,
    );
  }

  List<SelectionIconButtonChoice> _getHamburgerMenuBody() =>
      <SelectionIconButtonChoice>[
        const SelectionIconButtonChoice(
          title: 'Download',
          icon: Icons.cloud_download_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Share',
          icon: Icons.share_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Rename',
          icon: Icons.edit_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Delete',
          icon: Icons.delete_outlined,
        ),
      ];

  void _onHamburgerItemPressed(SelectionIconButtonChoice value) {
    switch (value.title) {
      case 'Share':
        _onSharePressed();
        return;

      case 'Rename':
        _onRenamePressed();
        return;

      case 'Delete':
        _onDeletePressed();
        return;

      case 'Download':
        _onDownloadPressed();
        return;

      default:
        stderr.write('User selected unrecognizable choice from dropdown menu.');
    }
  }

  void _onSharePressed() => onShareRequested();

  void _onRenamePressed() => onRenameRequested();

  void _onDeletePressed() => onDeleteRequested();

  void _onDownloadPressed() => onDownloadRequested();
}
