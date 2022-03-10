import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/widgets/selection_app_bar/selection_app_bar.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/details_popup.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

class FileExplorerSelectionAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const FileExplorerSelectionAppBar({
    Key? key,
    required this.selection,
    required this.allItems,
    required this.currentDirPath,
    required this.onActionFinalized,
  }) : super(key: key);

  final Selection selection;
  final List<FileItem> allItems;
  final String currentDirPath;
  final VoidCallback onActionFinalized;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _FileExplorerSelectionAppBarState createState() =>
      _FileExplorerSelectionAppBarState();
}

class _FileExplorerSelectionAppBarState
    extends State<FileExplorerSelectionAppBar> {
  late DirectoryManager _directoryManager;

  @override
  void initState() {
    _directoryManager = context.read<DirectoryManager>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionAppBar(
      selectionCount: widget.selection.amount,
      onDownload: _onDownloadPressed,
      onRename: _onRenamePressed,
      onDelete: _onDeletePressed,
      onShowDetails: _onDetailsPressed,
      onAddToFavorites: _onAddToFavouritesPressed,
    );
  }

  Future<void> _onRenamePressed() async {
    final selectedItems = _getSelectedItems();

    if (selectedItems.length > 1) {
      await RenameFilePopup(
        context: context,
        currentPath: widget.currentDirPath,
        amount: selectedItems.length,
        groupNamePicked: _renameSelectedItems,
        resourceId: '',
        currentName: '',
      ).showGroupRename();

      widget.onActionFinalized();
    } else if (selectedItems.length == 1) {
      await RenameFilePopup(
        context: context,
        currentPath: widget.currentDirPath,
        amount: selectedItems.length,
        groupNamePicked: _renameSelectedItems,
        resourceId: selectedItems[0].id!,
        currentName: selectedItems[0].title,
      ).show();

      widget.onActionFinalized();
    }
  }

  Future<void> _onAddToFavouritesPressed() async {
    //TODO
  }

  Future<void> _onDownloadPressed() async {
    for (final item in _getSelectedItems()) {
      try {
        await _directoryManager.downloadMediaToDevice(
          item.title,
          item.id!,
          context: context,
          setState: setState,
        );
      } catch (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              '${item.title} download failed.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: const Text(
          'Download completed.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    widget.onActionFinalized();
  }

  Future<void> _onDeletePressed() async {
    await showDialog<void>(
      context: context,
      builder: (context) => _getConfirmDeletePopop(),
    );

    widget.onActionFinalized();
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
              if (item.type == FileExplorerItemType.directory) {
                unawaited(_directoryManager.deleteDirectory(item.id!));
              } else {
                unawaited(_directoryManager.deleteFile(item.id!));
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
    FileItem currentItem,
    int currentIndex,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      title: Text('File $currentIndex/$length'),
      content: DetailsView(item: currentItem),
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

  Future<void> _renameSelectedItems(String newName) async {
    final selectedItems = _getSelectedItems();

    var counter = 1;
    for (final item in selectedItems) {
      final fileExtension = p.extension(item.title, 10);
      final newItemName = '$newName (${counter++})$fileExtension';

      await _directoryManager.rename(
        widget.currentDirPath,
        newItemName,
        item.id!,
      );
    }
  }

  List<FileItem> _getSelectedItems() {
    final list = <FileItem>[];

    for (final index in widget.selection.selectedIndexes) {
      list.add(widget.allItems[index]);
    }

    return list;
  }
}
