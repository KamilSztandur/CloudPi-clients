import 'package:app/contracts/api.enums.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:file_picker/file_picker.dart';

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
    return [
      FileItem(
        title: 'cloudy.jpg',
        lastModifiedOn: DateTime.now(),
        type: FileExplorerItemType.image,
        size: 1024,
        thumbnailURL:
            'https://img.redro.pl/obrazy/clouded-leopard-in-tree-700-113986304.jpg', // TODO: Handle thumbnails
      ),
      FileItem(
        title: 'pan tadeusz.txt',
        lastModifiedOn: DateTime.now(),
        type: FileExplorerItemType.text,
        size: 1024,
        thumbnailURL: null,
      ),
    ];
    /*
    // TODO: Use authorized user
    final result = await _api.filesystemUserUsernameGet(
      username: 'mighty root',
      fileStructureRoot: path,
    );

    if (result.isSuccessful) {
      return [
        ...(result.body?.rootDirectory?.files ?? []).map(
          (dto) => FileItem(
            title: dto.details!.name!,
            lastModifiedOn: dto.details!.modifiedAt!,
            type: _mapItemType(dto.details!.fileType!),
            size: dto.details!.size!.toDouble(),
            thumbnailURL: null, // TODO: Handle thumbnails
          ),
        ),
        ...(result.body?.rootDirectory?.directories ?? []).map(
          (dto) => FileItem(
            title: dto.details!.name!,
            lastModifiedOn: dto.details!.modifiedAt!,
            type: FileExplorerItemType.directory,
            size: dto.details!.size!.toDouble(),
            thumbnailURL: null,
          ),
        )
      ];
    } else {
      return null;
    }
    */
  }

  FileExplorerItemType _mapItemType(FileInfoDtoFileType fileType) {
    switch (fileType) {
      case FileInfoDtoFileType.image:
        return FileExplorerItemType.image;
      case FileInfoDtoFileType.video:
        return FileExplorerItemType.video;
      case FileInfoDtoFileType.textFile:
        return FileExplorerItemType.text;
      case FileInfoDtoFileType.music:
        return FileExplorerItemType.music;
      case FileInfoDtoFileType.compressed:
      case FileInfoDtoFileType.undefined:
      case FileInfoDtoFileType.swaggerGeneratedUnknown:
        return FileExplorerItemType.file;
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
