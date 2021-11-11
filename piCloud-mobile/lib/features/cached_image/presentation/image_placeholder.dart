import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ImagePlaceholder extends StatelessWidget {
  int? height, width;

  ImagePlaceholder({
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset(
          "assets/placeholder.jpg",
          height: _getSize(),
          width: _getSize(),
        ),
      ),
    );
  }

  double _getSize() {
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
    } else {
      size = 40.0;
    }

    return size;
  }
}
