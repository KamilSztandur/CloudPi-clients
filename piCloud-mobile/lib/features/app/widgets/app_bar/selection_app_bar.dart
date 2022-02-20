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
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
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
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onDetailsPressed() async {
    final selectedItems = _getSelectedItems();
    var i = 0;

    for (final item in selectedItems) {
      i++;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            title: Text('File $i/${selectedItems.length}'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getDetailWidget(
                    'Title',
                    item.file.title,
                  ),
                  _getDetailWidget(
                    'Type',
                    _formatType(item.file.type),
                  ),
                  _getDetailWidget(
                    'Last modified',
                    _formatDate(item.file.lastModifiedOn),
                  ),
                  if (item.file.type != FileExplorerItemType.directory)
                    _getDetailWidget(
                      'Size',
                      item.file.size.toString(),
                    )
                  else
                    Container(height: 0),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        },
      );
    }
  }

  Widget _getDetailWidget(String label, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _formatType(FileExplorerItemType type) {
    switch (type) {
      case FileExplorerItemType.directory:
        return 'Directory';
      case FileExplorerItemType.file:
        return 'File';
      case FileExplorerItemType.image:
        return 'Image';
      case FileExplorerItemType.music:
        return 'Music file';
      case FileExplorerItemType.pdf:
        return 'PDF file';
      case FileExplorerItemType.text:
        return 'Text file';
      case FileExplorerItemType.video:
        return 'Video';
    }
  }

  String _formatDate(DateTime dateTime) {
    final result = dateTime.toString();
    final indexOfDot = result.indexOf('.');
    return result.substring(0, indexOfDot);
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
