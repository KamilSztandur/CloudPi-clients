import 'dart:math';

import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_date_label.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/item_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FileExplorerListItem extends FileExplorerItem {
  FileExplorerListItem({
    Key? key,
    required FileItem file,
  }) : super(key: key, file: file);

  final colorOfAdditionalInfo = Colors.grey.shade700;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      child: _getContentOfItem(),
    );
  }

  Row _getContentOfItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 20,
          fit: FlexFit.tight,
          child: Row(
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: FileExplorerThumbnail(file: file),
              ),
              const Spacer(flex: 2),
              _getTitleAndSizeWidget()
            ],
          ),
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
          const Spacer(flex: 2),
          Flexible(
            flex: 30,
            fit: FlexFit.tight,
            child: Text(
              file.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
            flex: 12,
            child: _buildSizeLabel(),
          ),
        ],
      ),
    );
  }

  Flexible _getDateInfoWidget() {
    return Flexible(
      flex: 6,
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
    );
  }

  Widget _buildSizeLabel() {
    var label = '';
    final sizeInBytes = file.size;

    if (sizeInBytes > 10 ^ 6) {
      final sizeInMegabytes = sizeInBytes / pow(10, 6);
      label = '${sizeInMegabytes.toStringAsFixed(3)} Mb';
    } else if (sizeInBytes > 10 ^ 3) {
      final sizeInKilobytes = sizeInBytes / (pow(10, 3));
      label = '${sizeInKilobytes.toStringAsFixed(3)}Kb';
    } else {
      label = '{$sizeInBytes.toStringAsFixed(3)} b';
    }

    return Text(label, style: const TextStyle(color: Colors.grey));
  }

  String _getProperTimeFormat(DateTime dateTime) {
    return DateFormat('Hm').format(dateTime);
  }
}
