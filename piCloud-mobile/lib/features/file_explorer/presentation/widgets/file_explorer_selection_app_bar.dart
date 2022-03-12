import 'package:app/common/models/file_item.dart';
import 'package:app/common/widgets/selection_app_bar/selection_app_bar.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/details_popup.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

class FileExplorerSelectionAppBar extends StatelessWidget
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
  Widget build(BuildContext context) {
    return SelectionAppBar(
      selectionCount: selection.amount,
      onDownload: () => _onDownloadPressed(context),
      onRename: () => _onRenamePressed(context),
      onDelete: () => _onDeletePressed(context),
      onShowDetails: () => _onDetailsPressed(context),
      onToggleFavorites: () => _onAddToFavouritesPressed(context),
    );
  }

  Future<void> _onRenamePressed(BuildContext context) async {
    final selectedItems = _getSelectedItems();

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
        resourceId: selectedItems[0].id,
        currentName: selectedItems[0].title,
      ).show();

      onActionFinalized();
    }
  }

  Future<void> _onAddToFavouritesPressed(BuildContext context) async {
    await context.read<FavoritesManager>().toggleFavorite(
          _getSelectedItems().map((item) => item.id),
        );

    onActionFinalized();
  }

  Future<void> _onDownloadPressed(BuildContext context) async {
    for (final item in _getSelectedItems()) {
      try {
        await context.read<FileExplorerCubit>().downloadFile(
              item.title,
              item.id,
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

  Future<void> _onDeletePressed(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: _getConfirmDeletePopop,
    );

    onActionFinalized();
  }

  Future<void> _onDetailsPressed(BuildContext context) async {
    final selectedItems = _getSelectedItems();
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
    final cubit = context.read<FileExplorerCubit>();

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
              unawaited(cubit.deleteFile(item.id));
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
    final selectedItems = _getSelectedItems();

    var counter = 1;
    for (final item in selectedItems) {
      final fileExtension = p.extension(item.title, 10);
      final newItemName = '$newName (${counter++})$fileExtension';

      await context.read<FileExplorerCubit>().renameFile(
            currentDirPath,
            newItemName,
            item.id,
          );
    }
  }

  List<FileItem> _getSelectedItems() {
    final list = <FileItem>[];

    for (final index in selection.selectedIndexes) {
      list.add(allItems[index]);
    }

    return list;
  }
}
