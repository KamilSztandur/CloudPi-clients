import 'package:app/features/cached_image/presentation/cached_image.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:flutter/material.dart';

class FileExplorerThumbnail extends StatefulWidget {
  final FileItem file;

  FileExplorerThumbnail({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _FileExplorerThumbnailState createState() => _FileExplorerThumbnailState();
}

class _FileExplorerThumbnailState extends State<FileExplorerThumbnail> {
  AssetImage _getDefaultThumbnailByType() {
    switch (this.widget.file.type) {
      case FileExplorerItemType.DIRECTORY:
        return AssetImage("assets/thumbnails/directory.png");

      case FileExplorerItemType.IMAGE:
        return AssetImage("assets/thumbnails/image.png");

      case FileExplorerItemType.VIDEO:
        return AssetImage("assets/thumbnails/video.png");

      case FileExplorerItemType.MUSIC:
        return AssetImage("assets/thumbnails/sound.png");

      case FileExplorerItemType.TEXT:
        return AssetImage("assets/thumbnails/txt.png");

      case FileExplorerItemType.PDF:
        return AssetImage("assets/thumbnails/pdf.png");

      default:
        return AssetImage("assets/thumbnails/file.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.file.hasThumbnail()) {
      return BackendCachedImage(url: this.widget.file.thumbnailURL!);
    } else {
      return Image(
        fit: BoxFit.scaleDown,
        image: _getDefaultThumbnailByType(),
      );
    }
  }
}
