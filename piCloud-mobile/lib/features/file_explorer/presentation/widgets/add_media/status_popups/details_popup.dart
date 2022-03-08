import 'dart:math';

import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    Key? key,
    this.path,
    required this.item,
  }) : super(key: key);

  final FileItem item;
  final String? path;

  @override
  State<StatefulWidget> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getDetailWidget(
            'Title',
            widget.item.title,
          ),
          _getDetailWidget(
            'Type',
            _formatType(widget.item.type),
          ),
          _getDetailWidget(
            'Last modified',
            _formatDate(widget.item.lastModifiedOn),
          ),
          if (widget.path != null) _getDetailWidget('Path', widget.path!),
          if (widget.item.type != FileExplorerItemType.directory)
            _getDetailWidget(
              'Size',
              _getSizeLabel(),
            )
          else
            Container(height: 0),
        ],
      ),
    );
  }

  Widget _getDetailWidget(String label, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _formatType(FileExplorerItemType type) {
    switch (type) {
      case FileExplorerItemType.directory:
        return 'Directory';
      case FileExplorerItemType.file:
        return 'File';
      case FileExplorerItemType.image:
        return 'Image';
      case FileExplorerItemType.music:
        return 'Music file';
      case FileExplorerItemType.pdf:
        return 'PDF file';
      case FileExplorerItemType.text:
        return 'Text file';
      case FileExplorerItemType.video:
        return 'Video';
      case FileExplorerItemType.compressed:
        return 'Archive';
      default:
        return 'File';
    }
  }

  String _getSizeLabel() {
    var label = '';
    final sizeInBytes = widget.item.size;

    final megabytesThreshold = pow(10, 6);
    final kilobytesThreshold = pow(10, 3);

    if (sizeInBytes > megabytesThreshold) {
      final sizeInMegabytes = sizeInBytes / megabytesThreshold;
      label = '${sizeInMegabytes.toStringAsFixed(2)} Mb';
    } else if (sizeInBytes > kilobytesThreshold) {
      final sizeInKilobytes = sizeInBytes / kilobytesThreshold;
      label = '${sizeInKilobytes.toStringAsFixed(2)} Kb';
    } else if (sizeInBytes > 0) {
      label = '${sizeInBytes.floor().toString()} bytes';
    } else {
      label = 'Unknown';
    }

    return label;
  }

  String _formatDate(DateTime dateTime) {
    final result = dateTime.toString();
    final indexOfDot = result.indexOf('.');
    return result.substring(0, indexOfDot);
  }
}
