import 'dart:math';

import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/presentation/widgets/result/more_actions_menu.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_item_date_label.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_item_title_label.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_thumbnail.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SearchResult item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: SearchResultThumbnail(item: item),
          ),
          const Spacer(),
          Flexible(
            flex: 15,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ResultItemTitleLabel(title: item.title),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildSizeLabel(),
                      _buildDotSpacer(),
                      LastModifiedOnDateLabel(
                        lastModifiedOn: item.lastModifiedOn,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          MoreActionsMenu(item: item),
        ],
      ),
    );
  }

  Widget _buildSizeLabel() {
    var label = '';
    final sizeInBytes = item.size;

    if (sizeInBytes > 10 ^ 6) {
      final sizeInMegabytes = sizeInBytes / pow(10, 6);
      label = '${sizeInMegabytes.toStringAsFixed(3)} Mb';
    } else if (sizeInBytes > 10 ^ 3) {
      final sizeInKilobytes = sizeInBytes / pow(10, 3);
      label = '${sizeInKilobytes.toStringAsFixed(3)}Kb';
    } else {
      label = '{$sizeInBytes.toStringAsFixed(3)} b';
    }

    return Text(label, style: const TextStyle(color: Colors.grey));
  }

  Widget _buildDotSpacer() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.circle,
          color: Colors.grey,
          size: 5,
        ),
      );
}
