import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';

class FileItem {
  String title;
  double size;
  final FileExplorerItemType type;
  final Object thumbnail;
  DateTime lastModifiedOn;

  FileItem({
    required this.title,
    required this.lastModifiedOn,
    required this.type,
    required this.size,
    required this.thumbnail,
  });
}
