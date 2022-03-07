import 'dart:typed_data';

import 'package:app/common/models/file_explorer_item_type.dart';

class FileItem {
  FileItem({
    required this.title,
    required this.lastModifiedOn,
    required this.type,
    required this.size,
    required this.thumbnail,
    required this.id,
  });

  final String? id;
  final String title;
  final double size;
  final FileExplorerItemType type;
  final Uint8List? thumbnail;
  final DateTime lastModifiedOn;

  bool hasThumbnail() => thumbnail != null;
}
