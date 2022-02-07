import 'dart:typed_data';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class MediaReaderService {
  MimeTypeResolver typeResolver = MimeTypeResolver();

  //TODO
  Future<Uint8List> downloadBytes(Uri resoruce) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    const testURL =
        'https://img.redro.pl/obrazy/clouded-leopard-in-tree-700-113986304.jpg';

    final imageData = await NetworkAssetBundle(
      Uri.parse(testURL),
    ).load('');

    final bytes = imageData.buffer.asUint8List();

    return bytes;
  }

  MediaReaderSupportedTypes defineMediaType(String name) {
    final result = typeResolver.lookup(name);

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
}
