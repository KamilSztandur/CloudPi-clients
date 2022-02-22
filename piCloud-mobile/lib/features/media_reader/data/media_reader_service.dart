import 'dart:io';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class MediaReaderService {
  MediaReaderService(
    this._authManager,
  );

  final AuthManager _authManager;
  final _typeResolver = MimeTypeResolver();

  Future<Uint8List> downloadBytes(String resourcePubId) async {
    final headers = await _getHeaders();

    final request = http.Request(
      'GET',
      Uri.parse('${Config.apiBaseUrl}/files/file/$resourcePubId'),
    );

    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      return response.stream.toBytes();
    } else {
      throw HttpException(
        'Response different than 200: ${response.statusCode}',
      );
    }
  }

  MediaReaderSupportedTypes defineMediaType(String name) {
    final result = _typeResolver.lookup(name);

    if (result != null) {
      if (result.contains('image')) {
        return MediaReaderSupportedTypes.image;
      }

      if (result.contains('video')) {
        return MediaReaderSupportedTypes.video;
      }

      if (result.contains('audio')) {
        return MediaReaderSupportedTypes.audio;
      }

      if (result.contains('text')) {
        return MediaReaderSupportedTypes.txt;
      }

      if (result.contains('pdf')) {
        return MediaReaderSupportedTypes.pdf;
      }
    }

    return MediaReaderSupportedTypes.file;
  }

  Future<Map<String, String>> _getHeaders() async {
    var headers = {
      'Authorization': 'Bearer ${await _authManager.getAccessToken()}'
    };

    return headers;
  }
}
