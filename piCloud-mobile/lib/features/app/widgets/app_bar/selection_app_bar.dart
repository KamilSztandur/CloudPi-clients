import 'dart:io';

import 'package:app/contracts/client_index.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/selection_icon_button_choice.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SelectionAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key? key,
    this.title,
    this.selection = const Selection.empty(),
    required this.allItems,
    required this.api,
  }) : super(key: key);

  final Widget? title;
  final Selection selection;
  final List<FileExplorerItem> allItems;
  final Api api;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _SelectionAppBarState createState() => _SelectionAppBarState();
}

class _SelectionAppBarState extends State<SelectionAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: const CloseButton(),
      title: Text(_getTitle(), style: const TextStyle(color: Colors.white)),
      actions: [
        PopupMenuButton(
          onSelected: _onHamburgerItemPressed,
          itemBuilder: (context) => _getHamburgerMenuBody()
              .map(
                (choice) => PopupMenuItem<SelectionIconButtonChoice>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(choice.icon, color: Colors.black),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(choice.title!),
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

  String _getTitle() =>
      'Selected ${widget.selection.amount} item${widget.selection.amount > 1 ? 's.' : '.'}';

  List<SelectionIconButtonChoice> _getHamburgerMenuBody() =>
      <SelectionIconButtonChoice>[
        const SelectionIconButtonChoice(
          title: 'Move',
          icon: Icons.subdirectory_arrow_left_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Rename',
          icon: Icons.edit_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Download',
          icon: Icons.download_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Delete',
          icon: Icons.delete_forever_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Details',
          icon: Icons.info_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Add to Favourites',
          icon: Icons.star_outline_outlined,
        ),
      ];

  void _onHamburgerItemPressed(SelectionIconButtonChoice value) {
    switch (value.title) {
      case 'Move':
        _onMovePressed();
        return;

      case 'Rename':
        _onRenamePressed();
        return;

      case 'Download':
        _onDownloadPressed();
        return;

      case 'Delete':
        _onDeletePressed().whenComplete(() => null); //TODO: refresh items
        return;

      case 'Details':
        _onDetailsPressed();
        return;

      case 'Add to Favourites':
        _onAddToFavouritesPressed();
        return;

      default:
        stderr.write('User selected unrecognizable choice from dropdown menu.');
    }
  }

  void _onMovePressed() {
    //TODO
  }

  void _onRenamePressed() {
    //TODO
  }

  Future<void> _onDownloadPressed() async {
    //TODO
    for (final item in _getSelectedItems()) {
      final file = await widget.api.filesFileFileIdGet(fileId: item.file.id);
    }
  }

  Future<void> _onDeletePressed() async {
    final api = widget.api;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deleting...'),
          content: const SingleChildScrollView(
            child: Text(
              'Are you sure you want to delete selected files?',
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                for (final item in _getSelectedItems()) {
                  if (item.file.type == FileExplorerItemType.directory) {
                    await api.filesystemDirectoryDirectoryIdDelete(
                      directoryId: item.file.id,
                    );
                  } else {
                    await api.filesFileFileIdDelete(fileId: item.file.id);
                  }
                }

                Navigator.pop(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _onDetailsPressed() {
    //TODO
  }

  void _onAddToFavouritesPressed() {
    //TODO
  }

  List<FileExplorerItem> _getSelectedItems() {
    final list = <FileExplorerItem>[];

    for (final index in widget.selection.selectedIndexes) {
      list.add(widget.allItems[index]);
    }

    return list;
  }
}
