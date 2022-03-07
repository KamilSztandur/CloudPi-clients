import 'dart:math';

import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/details_popup.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/data/search_engine.dart';
import 'package:app/features/search_page/presentation/widgets/result/more_actions_menu.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_item_date_label.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_item_title_label.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_thumbnail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leancode_lint/leancode_lint.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ResultItem extends StatefulWidget {
  const ResultItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SearchResult item;

  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  late SearchEngine searchEngine;

  @override
  void initState() {
    searchEngine = context.read<SearchEngine>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onItemClicked,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: SearchResultThumbnail(item: widget.item),
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
                    ResultItemTitleLabel(title: widget.item.title),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildSizeLabel(),
                        _buildDotSpacer(),
                        LastModifiedOnDateLabel(
                          lastModifiedOn: widget.item.lastModifiedOn,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            MoreActionsMenu(
              item: widget.item,
              onDetailsClicked: _onDetailsClicked,
              onOpenLocalizationClicked: _onOpenLocalizationClicked,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeLabel() {
    var label = '';
    final sizeInBytes = widget.item.size;

    if (sizeInBytes > 10 ^ 6) {
      final sizeInMegabytes = sizeInBytes / pow(10, 6);
      label = '${sizeInMegabytes.toStringAsFixed(3)} Mb';
    } else if (sizeInBytes > 10 ^ 3) {
      final sizeInKilobytes = sizeInBytes / pow(10, 3);
      label = '${sizeInKilobytes.toStringAsFixed(3)} Kb';
    } else if (sizeInBytes > 0) {
      label = '${sizeInBytes.toStringAsFixed(3)} b';
    } else {
      label = 'Unknown';
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

  Future<void> _onItemClicked() async {
    if (widget.item.type == FileExplorerItemType.directory) {
      unawaited(_onOpenLocalizationClicked());
    } else {
      unawaited(
        AutoRouter.of(context).push(
          MediaReaderRoute(
            path: await _getFileLocalizationPath(),
            resourceName: widget.item.title,
            resourcePubId: widget.item.id,
          ),
        ),
      );
    }
  }

  Future<void> _onOpenLocalizationClicked() async =>
      AutoRouter.of(context).pushAll(await _getFullItemRouteList());

  Future<void> _onDetailsClicked() async {
    final path = await _getContainingDirectoryPath();

    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          title: Text(widget.item.title),
          content: DetailsView(
            item: searchEngine.parseSearchResultIntoFileItem(widget.item),
            path: path,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }

  Future<List<FileExplorerRoute>> _getFullItemRouteList() async {
    final routes = <FileExplorerRoute>[];

    final allPaths = await _getAllSuperDirectoriesPaths();
    for (final path in allPaths) {
      final route = FileExplorerRoute(path: path);

      routes.add(route);
    }

    return routes;
  }

  Future<List<String>> _getAllSuperDirectoriesPaths() async {
    final pathList = <String>[];
    var path = await _getContainingDirectoryPath();

    while (true) {
      final lastPathCharIndex = path.lastIndexOf('/');
      if (lastPathCharIndex == -1) {
        break;
      } else {
        pathList.add(path);
      }

      path = path.substring(0, path.length - 1);
      path = path.substring(
        0,
        path.lastIndexOf('/') + 1,
      );
    }

    final reversedPathList = List<String>.from(pathList.reversed);

    return reversedPathList;
  }

  Future<String> _getContainingDirectoryPath() async {
    final fullPath = await _getFileLocalizationPath();
    final directoryPath = fullPath.substring(
      fullPath.indexOf('/'),
      fullPath.lastIndexOf('/') + 1,
    );

    return directoryPath;
  }

  Future<String> _getFileLocalizationPath() async =>
      searchEngine.getFilePathFromPubId(widget.item.id!);
}
