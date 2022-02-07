import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class TextPreview extends StatefulWidget {
  const TextPreview({
    Key? key,
    required this.resourceBytes,
  }) : super(key: key);

  final Uint8List resourceBytes;

  @override
  _TextPreviewState createState() => _TextPreviewState();
}

class _TextPreviewState extends State<TextPreview> {
  @override
  Widget build(BuildContext context) => InteractiveViewer(
        minScale: 0.5,
        maxScale: 2,
        child: SingleChildScrollView(
          child: Scrollbar(
            isAlwaysShown: true,
            child: SelectableText(
              _getText(),
            ),
          ),
        ),
      );

  String _getText() {
    final text = String.fromCharCodes(widget.resourceBytes);
    final decodedText = const Utf8Decoder().convert(text.codeUnits);

    return decodedText;
  }
}
