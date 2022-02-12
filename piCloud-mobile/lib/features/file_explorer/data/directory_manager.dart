import 'dart:convert';
import 'package:app/contracts/api.enums.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/file_explorer/data/items_display.dart';
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
    final result = await _api.filesystemFileStructureGet(
      structureLevels: 1,
    );

    return [
      ...(result.body?.root?.children ?? []).map(
        (dto) => FileItem(
          title: dto.name!,
          lastModifiedOn: DateTime.parse(dto.modifiedAt!.toString()), // TODO
          type: _mapBodyTextToType(dto.type), // TODO
          size: dto.size!.toDouble(), // TODO
          thumbnailURL: null,
        ),
      ),
    ]; // TODO: Handle thumbnails
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

  FileExplorerItemType _mapBodyTextToType(FilesystemObjectDTOType? type) {
    switch (type) {
      case FilesystemObjectDTOType.directory:
        return FileExplorerItemType.directory;
      case FilesystemObjectDTOType.image:
        return FileExplorerItemType.image;
      case FilesystemObjectDTOType.video:
        return FileExplorerItemType.directory;
      case FilesystemObjectDTOType.textFile:
        return FileExplorerItemType.text;
      case FilesystemObjectDTOType.music:
        return FileExplorerItemType.music;
      case FilesystemObjectDTOType.compressed:
        return FileExplorerItemType.file;
      default:
        return FileExplorerItemType.file;
    }
  }
}
