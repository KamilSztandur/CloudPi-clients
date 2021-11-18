import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:flutter/material.dart';

class FileExplorerItemDateLabel extends StatelessWidget {
  final FileItem file;
  final bool? showYear;

  FileExplorerItemDateLabel({Key? key, required this.file, this.showYear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _getDateLabelText(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(color: Colors.grey.shade700),
    );
  }

  String _getDateLabelText() {
    String day = "${this.file.lastModifiedOn.day}";
    String month = _getMonthAcronym(this.file.lastModifiedOn.month);
    String year = "${this.file.lastModifiedOn.year}";

    if (showYear == true) {
      return "$day $month $year";
    } else if (DateTime.now().year != this.file.lastModifiedOn.year) {
      year = year.substring(year.length - 2);
      return "$day $month $year";
    } else {
      return "$day $month";
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
}
