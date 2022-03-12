import 'dart:io';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';

class UploadFileUseCase {
  const UploadFileUseCase(this._authManager);

  final AuthManager _authManager;

  Future<bool> invoke(String path, File file) async {
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

  Future<Map<String, String>> _getHeaders() async {
    return {'Authorization': 'Bearer ${await _authManager.getAccessToken()}'};
  }

  Future<String> _getCloudFilePath(String path, File file) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final filename = _getFilenameFromPath(file.path);
    final filepath = '$username$path$filename';

    return filepath;
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
          result.toLowerCase().contains('archive') ||
          result.toLowerCase().contains('zip')) {
        return 'COMPRESSED';
      }
    }

    return 'UNDEFINED';
  }

  String _getFilenameFromPath(String path) {
    final filename = path.split('/').last;

    return filename;
  }
}
