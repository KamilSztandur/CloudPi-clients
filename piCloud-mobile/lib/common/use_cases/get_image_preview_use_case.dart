import 'dart:convert';
import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:http/http.dart';

class GetImagePreviewUseCase {
  const GetImagePreviewUseCase(this._authManager);

  final AuthManager _authManager;

  Future<Uint8List?> invoke(String fileId) async {
    final headers = await _getHeaders()
      ..addAll({'Content-Type': 'application/json'});

    final request = Request(
      'GET',
      Uri.parse('${Config.apiBaseUrl}/files/image-preview'),
    )..body = json.encode([fileId]);

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

  Future<Map<String, String>> _getHeaders() async {
    return {'Authorization': 'Bearer ${await _authManager.getAccessToken()}'};
  }
}
