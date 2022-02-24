import 'dart:io';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:dio/dio.dart';
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

  Future<void> downloadMediaToDevice(String name, String pubId) async {
    final dioClient = Dio();

    final headers = await _getHeaders();
    final requestUrl = '${Config.apiBaseUrl}/files/file/$pubId';

    await dioClient.download(
      requestUrl,
      '/storage/emulated/0/Download/$name',
      onReceiveProgress: (received, total) {
        //TODO
      },
      options: Options(headers: headers),
    );
  }

  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      'Authorization': 'Bearer ${await _authManager.getAccessToken()}'
    };

    return headers;
  }
}
