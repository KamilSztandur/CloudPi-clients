import 'dart:math';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';

class DirectoryManager {
  // WARNING: Mock
  Future<List<FileItem>> getCurrentDirectoryItems(String path) async {
    List<FileItem> items = <FileItem>[];

    await Future.delayed(Duration(seconds: 5));

    for (int i = 0; i < 20; i++) {
      items.add(
        FileItem(
          title: "Plik $i",
          lastModifiedOn: DateTime.now(),
          type: FileExplorerItemType.values[Random().nextInt(6)],
          size: 20.0,
          thumbnail: Object(),
        ),
      );
    }

    return items;
  }
}
