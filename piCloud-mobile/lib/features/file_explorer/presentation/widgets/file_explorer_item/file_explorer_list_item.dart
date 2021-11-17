import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
import 'package:flutter/material.dart';

class FileExplorerListItem extends StatelessWidget {
  final FileItem file;

  const FileExplorerListItem({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: FileExplorerThumbnail(file: file),
            flex: 3,
          ),
          Spacer(
            flex: 2,
          ),
          Flexible(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(file.title,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  FileExplorerItemDateLabel(file: file)
                ],
              )),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
