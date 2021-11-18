import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
import 'package:flutter/material.dart';

class FileExplorerListItem extends FileExplorerItem {
  final Color colorOfAdditionalInfo = Colors.grey.shade700;

  FileExplorerListItem({Key? key, required file}) : super(key: key, file: file);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      child: _getContentOfItem(),
    );
  }

  Row _getContentOfItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: FileExplorerThumbnail(file: file),
                flex: 5,
                fit: FlexFit.tight,
              ),
              Spacer(flex: 2),
              _getTitleAndSizeWidget()
            ],
          ),
          flex: 20,
          fit: FlexFit.tight,
        ),
        _getDateInfoWidget(),
      ],
    );
  }

  Flexible _getTitleAndSizeWidget() {
    return Flexible(
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
              style: TextStyle(color: colorOfAdditionalInfo),
            ),
            flex: 12,
          ),
        ],
      ),
    );
  }

  Flexible _getDateInfoWidget() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _getProperTimeFormat(file.lastModifiedOn),
            style: TextStyle(color: colorOfAdditionalInfo),
          ),
          FileExplorerItemDateLabel(
            file: file,
            showYear: true,
          ),
        ],
      ),
      flex: 6,
    );
  }

  String _getProperTimeFormat(DateTime dateTime) {
    return dateTime.hour.toString() + ':' + dateTime.minute.toString();
  }
}
