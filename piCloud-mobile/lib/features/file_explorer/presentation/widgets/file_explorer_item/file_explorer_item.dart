import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
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
          Flexible(
            flex: 27,
            child: FileExplorerThumbnail(file: this.file),
            fit: FlexFit.tight,
          ),
          Flexible(flex: 1, child: Container(), fit: FlexFit.tight),
          Flexible(flex: 15, child: _getTitle(), fit: FlexFit.tight),
          Flexible(
            flex: 9,
            child: FileExplorerItemDateLabel(file: this.file),
            fit: FlexFit.loose,
          ),
        ],
      ),
    );
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
}
