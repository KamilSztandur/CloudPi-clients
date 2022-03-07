import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/widgets/download_indicator_popup.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<bool> isNameTaken(String path, String name) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final fileStructureWithRoot = '$username$path';

    final result = await _api.filesystemFileStructureGet(
      structureLevels: 1,
      fileStructureRoot: fileStructureWithRoot,
    );

    for (final dto in result.body?.root?.children ?? <FilesystemObjectDTO>[]) {
      if (dto.name == name) {
        return true;
      }
    }

    return false;
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

  Future<bool> deleteFile(String pubId) async {
    final result = await _api.filesFileFileIdDelete(fileId: pubId);

    return result.isSuccessful;
  }

  Future<bool> deleteDirectory(String pubId) async {
    final result = await _api.filesystemDirectoryDirectoryIdDelete(
      directoryId: pubId,
    );

    return result.isSuccessful;
  }

  Future<void> downloadMediaToDevice(
    String name,
    String pubId, {
    BuildContext? context,
    void Function(void Function())? setState,
  }) async {
    DownloadIndicatorPopup? progressIndicator;

    final dioClient = dio.Dio();

    final headers = await _getHeaders();
    final requestUrl = '${Config.apiBaseUrl}/files/file/$pubId';

    if (context != null) {
      progressIndicator = DownloadIndicatorPopup(
        context: context,
        progress: 0,
      )..show();
    }

    await dioClient.download(
      requestUrl,
      '/storage/emulated/0/Download/$name',
      onReceiveProgress: (received, total) {
        if (context != null) {
          progressIndicator!.updateProgress(setState!, received / total);
        }
      },
      options: dio.Options(headers: headers),
    );

    if (context != null) {
      progressIndicator!.close();
    }
  }

  Future<bool> rename(
    String containingDirectoryPath,
    String newName,
    String pubId,
  ) async {
    final path =
        '${await _authManager.getUsernameOfLoggedUser()}$containingDirectoryPath$newName';

    final result = await _api.filesystemMovePatch(
      body: MoveFileRequest(filePubId: pubId, newPath: path),
    );

    return result.isSuccessful;
  }

  Future<List<FileItem>?> _getRawList(String path) async {
    final fileExplorerItems = <FileItem>[];
    final username = await _authManager.getUsernameOfLoggedUser();

    final result = await _api.filesystemFileStructureGet(
      structureLevels: 1,
      fileStructureRoot: '$username$path',
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
    final headers = await _getHeaders()
      ..addAll({'Content-Type': 'application/json'});

    final request = Request(
      'GET',
      Uri.parse('${Config.apiBaseUrl}/files/image-preview'),
    )..body = json.encode([dto.pubId]);

    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      var encodedThumbnail = await response.stream.bytesToString();
      encodedThumbnail = encodedThumbnail.substring(
        2,
        encodedThumbnail.length - 2,
      );

      final decodedThumbnail = base64Decode(encodedThumbnail);
      return decodedThumbnail;
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
      if (result.toLowerCase().contains('image')) {
        return 'IMAGE';
      } else if (result.toLowerCase().contains('video')) {
        return 'VIDEO';
      } else if (result.toLowerCase().contains('text')) {
        return 'TEXT_FILE';
      } else if (result.toLowerCase().contains('pdf')) {
        return 'PDF';
      } else if (result.toLowerCase().contains('audio')) {
        return 'MUSIC';
      } else if (result.toLowerCase().contains('compressed') ||
          result.toLowerCase().contains('archive')) {
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
    final filename = path.split('/').last;

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
      case FilesystemObjectDTOType.pdf:
        return FileExplorerItemType.pdf;
      default:
        return FileExplorerItemType.file;
    }
  }
}
