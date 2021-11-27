import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
import 'package:flutter/material.dart';

class FileExplorerItem extends StatelessWidget {
  const FileExplorerItem({
    Key? key,
    required this.file,
  }) : super(key: key);

  final FileItem file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 27,
            fit: FlexFit.tight,
            child: FileExplorerThumbnail(file: file),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(),
          ),
          Flexible(
            flex: 15,
            fit: FlexFit.tight,
            child: _getTitle(),
          ),
          Flexible(
            flex: 9,
            child: FileExplorerItemDateLabel(file: file),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Center(
      child: Text(
        file.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
