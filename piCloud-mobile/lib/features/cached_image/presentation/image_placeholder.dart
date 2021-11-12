import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final int? height, width;

  ImagePlaceholder({
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("assets/placeholder.jpg"),
      height: _getSize(),
      width: _getSize(),
    );
    /*
        child: Image.asset(
          "assets/placeholder.jpg",
          height: _getSize(),
          width: _getSize(),
        ),
        */
  }

  double? _getSize() {
    double? size;

    if (height != null && width == null) {
      size = height!.toDouble();
    } else if (height == null && width != null) {
      size = height!.toDouble();
    } else if (height != null && width != null) {
      if (height! < width!) {
        size = height!.toDouble();
      } else {
        size = width!.toDouble();
      }
    }

    return size;
  }
}
