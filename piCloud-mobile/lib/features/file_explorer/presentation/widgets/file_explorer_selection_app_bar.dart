import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/file_permission.dart';
import 'package:app/common/widgets/selection_app_bar/selection_app_bar.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/details_popup.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/show_share_popup.dart';
import 'package:app/features/shared_page/data/shared_manager.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

class FileExplorerSelectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  FileExplorerSelectionAppBar({
    Key? key,
    required Selection selection,
    required List<FileItem> allItems,
    required this.currentDirPath,
    this.shared = false,
    required this.onActionFinalized,
  }) : super(key: key) {
    selectedItems = _getSelectedItems(selection, allItems);
  }

  late final List<FileItem> selectedItems;
  final String currentDirPath;
  final bool shared;
  final VoidCallback onActionFinalized;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canModify = !selectedItems
        .any((item) => !item.permissions.contains(FilePermission.modify));

    return SelectionAppBar(
      selectionCount: selectedItems.length,
      onDownload: () => _onDownloadPressed(context),
      onShare: !shared ? () => _onSharePressed(context) : null,
      onRename: canModify ? () => _onRenamePressed(context) : null,
      onDelete: canModify ? () => _onDeletePressed(context) : null,
      onShowDetails: () => _onDetailsPressed(context),
      onToggleFavorites:
          !shared ? () => _onAddToFavouritesPressed(context) : null,
    );
  }

  Future<void> _onRenamePressed(BuildContext context) async {
    if (selectedItems.length > 1) {
      await RenameFilePopup(
        context: context,
        currentPath: currentDirPath,
        amount: selectedItems.length,
        groupNamePicked: (name) => _renameSelectedItems(context, name),
        resourceId: '',
        currentName: '',
      ).showGroupRename();

      onActionFinalized();
    } else if (selectedItems.length == 1) {
      await RenameFilePopup(
        context: context,
        currentPath: currentDirPath,
        amount: selectedItems.length,
        groupNamePicked: (name) => _renameSelectedItems(context, name),
        resourceId: selectedItems[0].id!,
        currentName: selectedItems[0].title,
      ).show();

      onActionFinalized();
    }
  }

  Future<void> _onAddToFavouritesPressed(BuildContext context) async {
    await context.read<FavoritesManager>().toggleFavorite(
          selectedItems.map((item) => item.id!),
        );

    onActionFinalized();
  }

  Future<void> _onDownloadPressed(BuildContext context) async {
    for (final item in selectedItems) {
      try {
        await context.read<DirectoryManager>().downloadMediaToDevice(
              item.title,
              item.id!,
              context: context,
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

    onActionFinalized();
  }

  Future<void> _onSharePressed(BuildContext context) async {
    final sharePopupResult = await showSharePopup(context);

    if (sharePopupResult != null) {
      final username = sharePopupResult.username;
      final result = await context.read<SharedManager>().shareFiles(
            pubIds: selectedItems.map((item) => item.id!).toList(),
            userName: username,
            allowModification: sharePopupResult.allowModification,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            result
                ? 'Shared successfully with $username'
                : 'Failed to share this content with $username. Check if this username is valid.',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    onActionFinalized();
  }

  Future<void> _onDeletePressed(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: _getConfirmDeletePopop,
    );

    onActionFinalized();
  }

  Future<void> _onDetailsPressed(BuildContext context) async {
    var i = 0;

    for (final item in selectedItems) {
      i++;

      await showDialog<void>(
        context: context,
        builder: (context) => _getDetailsPopup(
          context,
          selectedItems.length,
          item,
          i,
        ),
      );
    }
  }

  Widget _getConfirmDeletePopop(BuildContext context) {
    final directoryManager = context.read<DirectoryManager>();

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
            for (final item in selectedItems) {
              if (item.type == FileExplorerItemType.directory) {
                unawaited(directoryManager.deleteDirectory(item.id!));
              } else {
                unawaited(directoryManager.deleteFile(item.id!));
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
    BuildContext context,
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

  Future<void> _renameSelectedItems(
    BuildContext context,
    String newName,
  ) async {
    var counter = 1;
    for (final item in selectedItems) {
      final fileExtension = p.extension(item.title, 10);
      final newItemName = '$newName (${counter++})$fileExtension';

      await context.read<DirectoryManager>().rename(
            currentDirPath,
            newItemName,
            item.id!,
          );
    }
  }

  List<FileItem> _getSelectedItems(
      Selection selection, List<FileItem> allItems) {
    return selection.selectedIndexes.map((index) => allItems[index]).toList();
  }
}
