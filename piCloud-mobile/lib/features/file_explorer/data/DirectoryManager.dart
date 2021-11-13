import 'dart:math';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';

class DirectoryManager {
  // WARNING: Mock
  Future<List<FileItem>> getCurrentDirectoryItems(String path) async {
    List<FileItem> items = <FileItem>[];

    await Future.delayed(Duration(seconds: 5));

    for (int i = 0; i < 20; i++) {
      FileExplorerItemType currentType =
          FileExplorerItemType.values[Random().nextInt(
        FileExplorerItemType.values.length,
      )];

      String title = currentType.toString();
      title = title.substring(title.indexOf('.') + 1, title.length) + " $i";
      title = title[0] + title.substring(1).toLowerCase();

      items.add(
        FileItem(
          title: title,
          lastModifiedOn: DateTime.now(),
          type: currentType,
          size: 20.0,
          thumbnailURL: null,
        ),
      );
    }

    items.add(
      FileItem(
        title: "Francuskie zamki długa nazwa",
        lastModifiedOn: DateTime.now(),
        type: FileExplorerItemType.IMAGE,
        size: 20.0,
        thumbnailURL:
            "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg",
      ),
    );

    return items;
  }
}
