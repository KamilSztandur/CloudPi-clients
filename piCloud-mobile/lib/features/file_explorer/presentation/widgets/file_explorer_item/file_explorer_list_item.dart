import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
import 'package:flutter/material.dart';

class FileExplorerListItem extends FileExplorerItem {
  FileExplorerListItem({Key? key, required file}) : super(key: key, file: file);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Flexible(
                child: FileExplorerThumbnail(file: file),
                flex: 5,
                fit: FlexFit.tight,
              ),
              Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(flex: 2),
                      Flexible(
                        child: Text(
                          file.title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        flex: 30,
                        fit: FlexFit.tight,
                      ),
                      Flexible(
                        child: Text(
                          file.size.toString() + ' Mb',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        flex: 12,
                      ),
                    ],
                  ))
            ]),
            flex: 20,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Column(
              children: [
                Text(
                  _getProperTimeFormat(file.lastModifiedOn),
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                FileExplorerItemDateLabel(file: file),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
            flex: 6,
          ),
        ],
      ),
    );
  }

  String _getProperTimeFormat(DateTime dateTime) {
    return dateTime.hour.toString() + ':' + dateTime.minute.toString();
  }
}
