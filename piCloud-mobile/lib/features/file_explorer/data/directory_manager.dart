import 'package:app/contracts/client_index.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';

class DirectoryManager {
  const DirectoryManager(this._api);

  final Api _api;

  Future<List<FileItem>?> getCurrentDirectoryItems(String path) async {
    final items = await _getRawList(path);

    if (items != null) {
      return _sortDirectoryItemsByTypeAndName(items);
    } else {
      return null;
    }
  }

  Future<List<FileItem>?> _getRawList(String path) async {
    final result =
        await _api.filesystemFileStructureGet(fileStructureRoot: path);

    if (result.isSuccessful) {
      return [
        ...(result.body?.root?.children ?? []).map(
          (dto) => FileItem(
            title: dto.name!,
            lastModifiedOn: DateTime.now(), // TODO
            type: FileExplorerItemType.file, // TODO
            size: 0, // TODO
            thumbnailURL: null, // TODO: Handle thumbnails
          ),
        ),
      ];
    } else {
      return null;
    }
  }

  List<FileItem> _sortDirectoryItemsByTypeAndName(List<FileItem> items) {
    return items
      ..sort(
        (a, b) {
          final typeComparison = a.type.index - b.type.index;
          if (typeComparison == 0) {
            return a.title.compareTo(b.title);
          } else {
            return typeComparison;
          }
        },
      );
  }
}
