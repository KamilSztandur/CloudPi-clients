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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getIcon(),
          _getTitle(),
          SizedBox(height: 5.0),
          _getDateLabel(),
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

  Icon _getIcon() {
    final double iconSize = 80.0;

    switch (this.file.type) {
      case FileExplorerItemType.DIRECTORY:
        return Icon(
          Icons.folder,
          size: iconSize,
          color: Colors.yellow.shade700,
        );

      case FileExplorerItemType.FILE:
        return Icon(
          Icons.file_copy,
          size: iconSize,
          color: Colors.grey.shade700,
        );

      case FileExplorerItemType.IMAGE:
        return Icon(
          Icons.image,
          size: iconSize,
          color: Colors.blue.shade700,
        );

      case FileExplorerItemType.VIDEO:
        return Icon(
          Icons.movie,
          size: iconSize,
          color: Colors.purple.shade700,
        );

      case FileExplorerItemType.MUSIC:
        return Icon(
          Icons.music_note,
          size: iconSize,
          color: Colors.green.shade700,
        );

      case FileExplorerItemType.TEXT:
        return Icon(
          Icons.text_snippet,
          size: iconSize,
          color: Colors.black,
        );

      default:
        return Icon(
          Icons.error,
          size: iconSize,
          color: Colors.red,
        );
    }
  }

  Text _getTitle() {
    return Text(
      "${this.file.title}",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _getDateLabel() {
    return Text(
      _getDateLabelText(),
      style: TextStyle(
        color: Colors.grey.shade700,
      ),
    );
  }
}
