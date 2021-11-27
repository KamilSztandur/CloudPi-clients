import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final int? height, width;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/placeholder.jpg'),
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
