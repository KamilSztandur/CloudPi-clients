import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageManager {
  Future<Image> fetchImageFromBackend(String url) async {
    final parsedUrl = Uri.parse(url);
    final fetchedBytes = await NetworkAssetBundle(parsedUrl).load(url);

    return Image.memory(
      fetchedBytes.buffer.asUint8List(),
    );
  }

  Future<Image> setValidImageSize(Image image, int? height, int? width) async {
    final fixedHeight = await _getFixedImageHeight(image, height, width);
    final fixedWidth = await _getFixedImageWidth(image, height, width);

    final resizedImage = ResizeImage(
      image.image,
      width: fixedWidth,
      height: fixedHeight,
    );

    return Image(image: resizedImage);
  }

  Future<int> _getFixedImageHeight(Image image, int? height, int? width) async {
    final originalImageHeight = await _getOriginalImageHeight(image);
    final originalImageWidth = await _getOriginalImageWidth(image);

    if (height != null) {
      return height;
    } else if (width != null) {
      return (originalImageHeight * (width / originalImageWidth)).round();
    } else {
      return originalImageHeight;
    }
  }

  Future<int> _getFixedImageWidth(Image image, int? height, int? width) async {
    final originalImageHeight = await _getOriginalImageHeight(image);
    final originalImageWidth = await _getOriginalImageWidth(image);

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

  Future<Size> _getOriginalImageSize(Image image) {
    final completer = Completer<Size>();

    image.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener(
        (info, _) {
          completer.complete(
            Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ),
          );
        },
      ),
    );

    return completer.future;
  }
}
