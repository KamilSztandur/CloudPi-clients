import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackupDisplay extends StatelessWidget {
  final double? size;

  BackupDisplay({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.file_copy,
      size: this.size,
      color: Colors.grey.shade700,
    );
  }
}
