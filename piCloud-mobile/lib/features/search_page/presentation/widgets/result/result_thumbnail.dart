import 'package:app/features/cached_image/presentation/cached_image.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:flutter/material.dart';

class SearchResultThumbnail extends StatefulWidget {
  const SearchResultThumbnail({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SearchResult item;

  @override
  _SearchResultThumbnailState createState() => _SearchResultThumbnailState();
}

class _SearchResultThumbnailState extends State<SearchResultThumbnail> {
  AssetImage _getDefaultThumbnailByType() {
    switch (widget.item.type) {
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
    if (widget.item.hasThumbnail()) {
      return BackendCachedImage(url: widget.item.thumbnailURL!);
    } else {
      return Image(
        fit: BoxFit.scaleDown,
        image: _getDefaultThumbnailByType(),
      );
    }
  }
}
