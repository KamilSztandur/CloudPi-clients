import 'package:flutter/material.dart';

class BackupDisplay extends StatelessWidget {
  final int? height, width;

  BackupDisplay({
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.file_copy,
      size: _getSize(),
      color: Colors.grey.shade700,
    );
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
