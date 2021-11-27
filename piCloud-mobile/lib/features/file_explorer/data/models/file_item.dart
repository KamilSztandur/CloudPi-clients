import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';

class FileItem {
  FileItem({
    required this.title,
    required this.lastModifiedOn,
    required this.type,
    required this.size,
    required this.thumbnailURL,
  });

  final String title;
  final double size;
  final FileExplorerItemType type;
  final String? thumbnailURL;
  final DateTime lastModifiedOn;

  bool hasThumbnail() => thumbnailURL != null;
}
