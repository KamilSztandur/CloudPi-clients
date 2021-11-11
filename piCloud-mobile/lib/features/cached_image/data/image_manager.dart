import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class ImageManager {
  Future<Image> fetchImageFromBackend(String url) async {
    Uri parsedUrl = Uri.parse(url);
    ByteData fetchedBytes = await NetworkAssetBundle(parsedUrl).load(url);

    return Image.memory(
      fetchedBytes.buffer.asUint8List(),
    );
  }

  Future<Image> resizeMemoryImage(Image image, int? height, int? width) async {
    int fixedHeight = await _getFixedImageHeight(image, height, width);
    int fixedWidth = await _getFixedImageWidth(image, height, width);

    ResizeImage resizedImage = ResizeImage(
      image.image,
      width: fixedWidth,
      height: fixedHeight,
    );

    return Image(image: resizedImage);
  }

  Future<int> _getFixedImageHeight(Image image, int? height, int? width) async {
    int originalImageHeight = await _getOriginalImageHeight(image);
    int originalImageWidth = await _getOriginalImageWidth(image);

    if (height != null) {
      return height;
    } else if (width != null) {
      return (originalImageHeight * (width / originalImageWidth)).round();
    } else {
      return originalImageHeight;
    }
  }

  Future<int> _getFixedImageWidth(Image image, int? height, int? width) async {
    int originalImageHeight = await _getOriginalImageHeight(image);
    int originalImageWidth = await _getOriginalImageWidth(image);

    if (width != null) {
      return width;
    } else if (height != null) {
      return (originalImageWidth * (height / originalImageHeight)).round();
    } else {
      return originalImageWidth;
    }
  }

  Future<int> _getOriginalImageHeight(Image image) async {
    return (await _getOriginalImageSize(image)).height.toInt();
  }

  Future<int> _getOriginalImageWidth(Image image) async {
    return (await _getOriginalImageSize(image)).width.toInt();
  }

  Future<Size> _getOriginalImageSize(Image image) async {
    final Completer completer = Completer();

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    return await completer.future;
  }
}
