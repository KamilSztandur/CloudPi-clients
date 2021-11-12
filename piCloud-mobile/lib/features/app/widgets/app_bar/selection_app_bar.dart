import 'dart:io';

import 'package:app/features/file_explorer/data/SelectionIconButtonchoice.dart';
import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key? key,
    this.title,
    this.selection = const Selection.empty(),
  }) : super(key: key);

  final Widget? title;
  final Selection selection;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: CloseButton(),
      title: Text(_getTitle(), style: TextStyle(color: Colors.white)),
      actions: [
        PopupMenuButton(
          onSelected: _onHamburgerItemPressed,
          itemBuilder: (context) => _getHamburgerMenuBody()
              .map((choice) => PopupMenuItem<SelectionIconButtonChoice>(
                    value: choice,
                    child: Row(
                      children: [
                        Icon(choice.icon, color: Colors.black),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(choice.title!),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  String _getTitle() =>
      "Selected ${this.selection.amount} item" +
      (this.selection.amount > 1 ? "s." : ".");

  List<SelectionIconButtonChoice> _getHamburgerMenuBody() =>
      <SelectionIconButtonChoice>[
        SelectionIconButtonChoice(
          title: "Move",
          icon: Icons.subdirectory_arrow_left_outlined,
        ),
        SelectionIconButtonChoice(
          title: "Rename",
          icon: Icons.edit_outlined,
        ),
        SelectionIconButtonChoice(
          title: "Download",
          icon: Icons.download_outlined,
        ),
        SelectionIconButtonChoice(
          title: "Delete",
          icon: Icons.delete_forever_outlined,
        ),
        SelectionIconButtonChoice(
          title: "Details",
          icon: Icons.info_outlined,
        ),
        SelectionIconButtonChoice(
          title: "Add to Favourites",
          icon: Icons.star_outline_outlined,
        ),
      ];

  void _onHamburgerItemPressed(SelectionIconButtonChoice value) {
    switch (value.title) {
      case "Move":
        _onMovePressed();
        return;

      case "Rename":
        _onRenamePressed();
        return;

      case "Download":
        _onDownloadPressed();
        return;

      case "Delete":
        _onDeletePressed();
        return;

      case "Details":
        _onDetailsPressed();
        return;

      case "Add to Favourites":
        _onAddToFavouritesPressed();
        return;

      default:
        stderr.write("User selected unrecognizable choice from dropdown menu.");
    }
  }

  void _onMovePressed() {
    //TODO
  }

  void _onRenamePressed() {
    //TODO
  }

  void _onDownloadPressed() {
    //TODO
  }

  void _onDeletePressed() {
    //TODO
  }

  void _onDetailsPressed() {
    //TODO
  }

  void _onAddToFavouritesPressed() {
    //TODO
  }
}
