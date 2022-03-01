import 'dart:io';

import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/selection_icon_button_choice.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:pedantic/pedantic.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class SelectionAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key? key,
    this.title,
    this.selection = const Selection.empty(),
    required this.allItems,
    required this.currentDirPath,
    required this.onActionFinalized,
  }) : super(key: key);

  final Widget? title;
  final Selection selection;
  final List<FileExplorerItem> allItems;
  final String currentDirPath;
  final VoidCallback onActionFinalized;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _SelectionAppBarState createState() => _SelectionAppBarState();
}

class _SelectionAppBarState extends State<SelectionAppBar> {
  late DirectoryManager _directoryManager;

  @override
  void initState() {
    _directoryManager = context.read<DirectoryManager>();
    super.initState();
  }

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
          title: 'Download',
          icon: Icons.download_outlined,
        ),
        const SelectionIconButtonChoice(
          title: 'Rename',
          icon: Icons.edit_outlined,
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

  Future<void> _onHamburgerItemPressed(SelectionIconButtonChoice value) async {
    switch (value.title) {
      case 'Rename':
        await _onRenamePressed();
        widget.onActionFinalized();
        return;

      case 'Download':
        await _onDownloadPressed();
        widget.onActionFinalized();
        return;

      case 'Delete':
        await _onDeletePressed();
        widget.onActionFinalized();
        return;

      case 'Details':
        await _onDetailsPressed();
        widget.onActionFinalized();
        return;

      case 'Add to Favourites':
        await _onAddToFavouritesPressed();
        widget.onActionFinalized();
        return;

      default:
        stderr.write('User selected unrecognizable choice from dropdown menu.');
        widget.onActionFinalized();
    }
  }

  Future<void> _onRenamePressed() async {
    final selectedItems = _getSelectedItems();

    await RenameFilePopup(
      context: context,
      currentPath: widget.currentDirPath,
      amount: selectedItems.length,
      groupNamePicked: _renameSelectedItems,
      resourceId: '',
      currentName: '',
    ).showGroupRename();
  }

  Future<void> _onAddToFavouritesPressed() async {
    //TODO
  }

  Future<void> _onDownloadPressed() async {
    for (final item in _getSelectedItems()) {
      unawaited(
        _directoryManager.downloadMediaToDevice(
          item.file.title,
          item.file.id!,
        ),
      );
    }
  }

  Future<void> _onDeletePressed() async {
    await showDialog<void>(
      context: context,
      builder: (context) => _getConfirmDeletePopop(),
    );
  }

  Future<void> _onDetailsPressed() async {
    final selectedItems = _getSelectedItems();
    var i = 0;

    for (final item in selectedItems) {
      i++;

      await showDialog<void>(
        context: context,
        builder: (context) => _getDetailsPopup(selectedItems.length, item, i),
      );
    }
  }

  Widget _getConfirmDeletePopop() {
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
                unawaited(_directoryManager.deleteDirectory(item.file.id!));
              } else {
                unawaited(_directoryManager.deleteFile(item.file.id!));
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
  }

  Widget _getDetailsPopup(
    int length,
    FileExplorerItem currentItem,
    int currentIndex,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      title: Text('File $currentIndex/$length'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getDetailWidget(
              'Title',
              currentItem.file.title,
            ),
            _getDetailWidget(
              'Type',
              _formatType(currentItem.file.type),
            ),
            _getDetailWidget(
              'Last modified',
              _formatDate(currentItem.file.lastModifiedOn),
            ),
            if (currentItem.file.type != FileExplorerItemType.directory)
              _getDetailWidget(
                'Size',
                currentItem.file.size.toString(),
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

  Future<void> _renameSelectedItems(String newName) async {
    final selectedItems = _getSelectedItems();

    var counter = 1;
    for (final item in selectedItems) {
      final fileExtension = p.extension(item.file.title, 10);
      final newItemName = '$newName (${counter++})$fileExtension';
      final result = await _directoryManager.rename(
        widget.currentDirPath,
        newItemName,
        item.file.id!,
      );

      print(result);
    }
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

  List<FileExplorerItem> _getSelectedItems() {
    final list = <FileExplorerItem>[];

    for (final index in widget.selection.selectedIndexes) {
      list.add(widget.allItems[index]);
    }

    return list;
  }
}
