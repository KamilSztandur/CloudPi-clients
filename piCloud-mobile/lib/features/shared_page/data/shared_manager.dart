import 'dart:convert';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/extensions/shared_file_info_dto_permissions.dart';
import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:http/http.dart';

class SharedManager {
  const SharedManager(
    this._api,
    this._authManager,
  );

  final Api _api;
  final AuthManager _authManager;

  Future<bool> shareFiles({
    required List<String> pubIds,
    required String userName,
    required bool allowModification,
  }) async {
    try {
      final results = await Future.wait(
        pubIds.map(
          (pubId) => _api.filePermissionPermissionsPost(
            body: PostAddPermissionRequest(
              filePubId: pubId,
              ownerUsername: userName,
              permissions: [
                PostAddPermissionRequestPermissions.read,
                if (allowModification)
                  PostAddPermissionRequestPermissions.modify,
              ],
            ),
          ),
        ),
      );

      return !results.any((result) => !result.isSuccessful);
    } catch (e) {
      return false;
    }
  }

  Future<List<FileItem>?> getCurrentDirectoryItems() async {
    final items = await _getRawList();

    if (items != null) {
      return _sortDirectoryItemsByTypeAndName(items);
    } else {
      return null;
    }
  }

  Future<List<FileItem>?> _getRawList() async {
    final fileExplorerItems = <FileItem>[];

    final result = await _api.filesystemFilesSharedToUserGet();

    for (final dto in result.body ?? <SharedFileInfoDTO>[]) {
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
          isFavorite: dto.isFavourite ?? false,
          permissions: dto.permissions!.toFilePermissionSet(),
        ),
      );
    }
    return fileExplorerItems;
  }

  Future<Uint8List?> _getImagePreview(SharedFileInfoDTO dto) async {
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

  Future<Map<String, String>> _getHeaders() async {
    return {'Authorization': 'Bearer ${await _authManager.getAccessToken()}'};
  }

  FileExplorerItemType _mapBodyTextToType(SharedFileInfoDTOType? type) {
    switch (type) {
      case SharedFileInfoDTOType.directory:
        return FileExplorerItemType.directory;
      case SharedFileInfoDTOType.image:
        return FileExplorerItemType.image;
      case SharedFileInfoDTOType.video:
        return FileExplorerItemType.directory;
      case SharedFileInfoDTOType.textFile:
        return FileExplorerItemType.text;
      case SharedFileInfoDTOType.music:
        return FileExplorerItemType.music;
      case SharedFileInfoDTOType.compressed:
        return FileExplorerItemType.file;
      case SharedFileInfoDTOType.pdf:
        return FileExplorerItemType.pdf;
      default:
        return FileExplorerItemType.file;
    }
  }
}
