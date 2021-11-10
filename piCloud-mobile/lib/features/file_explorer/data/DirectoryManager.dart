import 'dart:math';

import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item.dart';

class DirectoryManager {
  // WARNING: Mock
  Future<List<FileExplorerItem>> getCurrentDirectoryItems(String path) async {
    List<FileExplorerItem> items = <FileExplorerItem>[];

    await Future.delayed(Duration(seconds: 5));

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
}
