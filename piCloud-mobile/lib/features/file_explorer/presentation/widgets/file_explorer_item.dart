import 'package:app/features/cached_image/presentation/cached_image.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileExplorerItem extends StatelessWidget {
  final FileItem file;

  FileExplorerItem({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 27, child: _getThumbnail(), fit: FlexFit.tight),
          Flexible(flex: 1, child: Container(), fit: FlexFit.tight),
          Flexible(flex: 15, child: _getTitle(), fit: FlexFit.tight),
          Flexible(flex: 9, child: _getDateLabel(), fit: FlexFit.loose),
        ],
      ),
    );
  }

  String _getDateLabelText() {
    String day = "${this.file.lastModifiedOn.day}";
    String month = _getMonthAcronym(this.file.lastModifiedOn.month);
    String year = "${this.file.lastModifiedOn.year}";
    year = year.substring(year.length - 2);

    if (DateTime.now().year == this.file.lastModifiedOn.year) {
      return "$day $month";
    } else {
      return "$day $month $year";
    }
  }

  String _getMonthAcronym(int index) {
    switch (index) {
      case 1:
        return "jan";
      case 2:
        return "feb";
      case 3:
        return "mar";
      case 4:
        return "apr";
      case 5:
        return "may";
      case 6:
        return "jun";
      case 7:
        return "jul";
      case 8:
        return "aug";
      case 9:
        return "sep";
      case 10:
        return "oct";
      case 11:
        return "nov";
      case 12:
        return "dec";
      default:
        return "";
    }
  }

  Widget _getThumbnail() {
    if (this.file.hasThumbnail()) {
      return BackendCachedImage(url: this.file.thumbnailURL!);
    } else {
      return Image(
        fit: BoxFit.scaleDown,
        image: _getDefaultThumbnailByType(),
      );
    }
  }

  AssetImage _getDefaultThumbnailByType() {
    switch (this.file.type) {
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

  Widget _getTitle() {
    return Center(
      child: Text(
        "${this.file.title}",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Text _getDateLabel() {
    return Text(
      _getDateLabelText(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(color: Colors.grey.shade700),
    );
  }
}
