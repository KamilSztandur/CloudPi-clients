import 'dart:math';

import 'package:app/features/file_explorer/data/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FileExplorerView extends StatefulWidget {
  @override
  _FileExplorerViewState createState() => _FileExplorerViewState();
}

class _FileExplorerViewState extends State<FileExplorerView> {
  final _gridViewController = DragSelectGridViewController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<FileExplorerItem> sortedItems = _sortDirectoryItems(
      _getDirectoryItems(),
    );

    return RawScrollbar(
      thickness: 7.5,
      isAlwaysShown: true,
      thumbColor: Theme.of(context).primaryColor.withOpacity(0.5),
      radius: Radius.circular(5.0),
      controller: _scrollController,
      child: DragSelectGridView(
        triggerSelectionOnTap: true,
        dragStartBehavior: DragStartBehavior.down,
        gridController: this._gridViewController,
        padding: EdgeInsets.all(8),
        itemCount: sortedItems.length,
        itemBuilder: (context, index, selected) {
          return sortedItems[index];
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
      ),
    );
  }

  // WARNING: Mock
  List<FileExplorerItem> _getDirectoryItems() {
    List<FileExplorerItem> items = <FileExplorerItem>[];

    for (int i = 0; i < 20; i++) {
      items.add(
        FileExplorerItem(
          title: "Plik $i",
          lastModifiedOn: DateTime.now(),
          type: FileExplorerItemType.values[Random().nextInt(6)],
        ),
      );
    }

    return items;
  }

  List<FileExplorerItem> _sortDirectoryItems(List<FileExplorerItem> items) {
    List<FileExplorerItem> sortedList = <FileExplorerItem>[];

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.DIRECTORY) {
        sortedList.add(item);
      }
    });

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.IMAGE) {
        sortedList.add(item);
      }
    });

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.VIDEO) {
        sortedList.add(item);
      }
    });

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.MUSIC) {
        sortedList.add(item);
      }
    });

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.TEXT) {
        sortedList.add(item);
      }
    });

    items.forEach((FileExplorerItem item) {
      if (item.type == FileExplorerItemType.FILE) {
        sortedList.add(item);
      }
    });

    return sortedList;
  }
}
