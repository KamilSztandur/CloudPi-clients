import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    Key? key,
    required this.resourceBytes,
  }) : super(key: key);

  final Uint8List resourceBytes;

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) => InteractiveViewer(
        minScale: 0.5,
        maxScale: 2,
        child: Center(
          child: Image.memory(widget.resourceBytes),
        ),
      );
}
