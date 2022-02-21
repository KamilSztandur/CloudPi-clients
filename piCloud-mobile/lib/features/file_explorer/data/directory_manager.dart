import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/contracts/api.enums.swagger.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';

class DirectoryManager {
  const DirectoryManager(
    this._api,
    this._authManager,
  );

  final Api _api;
  final AuthManager _authManager;

  Future<List<FileItem>?> getCurrentDirectoryItems(String path) async {
    final items = await _getRawList(path);

    if (items != null) {
      return _sortDirectoryItemsByTypeAndName(items);
    } else {
      return null;
    }
  }

  Future<bool> createNewDirectory(String path, String name) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final result = await _api.filesystemDirectoryPut(
      directoryPath: '$username$path$name',
    );

    return result.isSuccessful;
  }

  Future<bool> uploadFile(String path, File file) async {
    final headers = await _getHeaders();
    final cloudPath = await _getCloudFilePath(path, file);
    final multipartFile = await MultipartFile.fromPath('file', file.path);

    final request = MultipartRequest(
      'POST',
      Uri.parse('${Config.apiBaseUrl}/files/file/'),
    );
    request.fields.addAll({
      'filepath': cloudPath,
      'fileType': _getFileTypeBasedOnFile(file),
    });
    request.files.add(multipartFile);
    request.headers.addAll(headers);

    final response = await request.send();
    return response.statusCode == 201;
  }

  Future<bool> uploadPhoto(String path, File file) async {
    final result = await uploadFile(path, file);

    return result;
  }

  Future<List<FileItem>?> _getRawList(String path) async {
    final fileExplorerItems = <FileItem>[];

    final result = await _api.filesystemFileStructureGet(
      structureLevels: 999,
      fileStructureRoot: path,
    );

    for (final dto in result.body?.root?.children ?? <FilesystemObjectDTO>[]) {
      final id = dto.pubId;
      final title = dto.name!;
      final lastModifiedOn = DateTime.parse(dto.modifiedAt!.toString());
      final type = _mapBodyTextToType(dto.type);
      final size = dto.size!.toDouble();
      final thumbnail = type == FileExplorerItemType.image
          ? await _getImagePreview(dto)
          : null;

      fileExplorerItems.add(
        FileItem(
          id: id,
          title: title,
          lastModifiedOn: lastModifiedOn,
          type: type,
          size: size,
          thumbnail: thumbnail,
        ),
      );
    }

    return fileExplorerItems;
  }

  Future<Uint8List?> _getImagePreview(FilesystemObjectDTO dto) async {
    final result = await _api.filesImagePreviewGet(
      previewResolution: 64,
      imageIds: [dto.pubId!],
    );

    print(dto.pubId);

    if (result.isSuccessful) {
      final decodedResult = base64Decode(result.bodyString);

      return decodedResult;
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

  String _getFileTypeBasedOnFile(File file) {
    final result = lookupMimeType(_getFilenameFromPath(file.path));

    if (result != null) {
      if (result.contains('image')) {
        return 'IMAGE';
      } else if (result.contains('video')) {
        return 'VIDEO';
      } else if (result.contains('text')) {
        return 'TEXT_FILE';
      } else if (result.contains('pdf')) {
        return 'PDF';
      } else if (result.contains('audio')) {
        return 'MUSIC';
      } else if (result.contains('compressed') || result.contains('archive')) {
        return 'COMPRESSED';
      }
    }

    return 'UNDEFINED';
  }

  Future<Map<String, String>> _getHeaders() async {
    return {'Authorization': 'Bearer ${await _authManager.getAccessToken()}'};
  }

  Future<String> _getCloudFilePath(String path, File file) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final filename = _getFilenameFromPath(file.path);
    final filepath = '$username$path$filename';

    return filepath;
  }

  String _getFilenameFromPath(String path) {
    var filename = path.split('/').last;
    filename = filename.substring(1, filename.length);

    return filename;
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
