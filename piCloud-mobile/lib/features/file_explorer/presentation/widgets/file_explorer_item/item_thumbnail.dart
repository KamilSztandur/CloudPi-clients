import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:flutter/material.dart';

class FileExplorerThumbnail extends StatefulWidget {
  const FileExplorerThumbnail({
    Key? key,
    required this.file,
  }) : super(key: key);

  final FileItem file;

  @override
  _FileExplorerThumbnailState createState() => _FileExplorerThumbnailState();
}

class _FileExplorerThumbnailState extends State<FileExplorerThumbnail> {
  AssetImage _getDefaultThumbnailByType() {
    switch (widget.file.type) {
      case FileExplorerItemType.directory:
        return const AssetImage('assets/thumbnails/directory.png');

      case FileExplorerItemType.image:
        return const AssetImage('assets/thumbnails/image.png');

      case FileExplorerItemType.video:
        return const AssetImage('assets/thumbnails/video.png');

      case FileExplorerItemType.music:
        return const AssetImage('assets/thumbnails/sound.png');

      case FileExplorerItemType.text:
        return const AssetImage('assets/thumbnails/txt.png');

      case FileExplorerItemType.pdf:
        return const AssetImage('assets/thumbnails/pdf.png');

      default:
        return const AssetImage('assets/thumbnails/file.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.file.hasThumbnail()) {
      return Image.memory(widget.file.thumbnail!);
    } else {
      return Image(
        fit: BoxFit.scaleDown,
        image: _getDefaultThumbnailByType(),
      );
    }
  }
}
