import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ImagePlaceholder extends StatelessWidget {
  double? height, width;

  ImagePlaceholder({
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/placeholder.png",
      height: this.height,
      width: this.width,
    );
  }
}
