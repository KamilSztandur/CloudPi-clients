import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/widgets/files_view/files_view.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class FileExplorerView extends StatelessWidget {
  const FileExplorerView({
    Key? key,
    required this.path,
    required this.files,
    required this.onSelectionChanged,
  }) : super(key: key);

  final String path;
  final List<FileItem> files;
  final ValueChanged<Selection> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return FilesView(
      files: files,
      onSelectionChanged: onSelectionChanged,
      onFileTapped: (file) {
        if (file.type == FileExplorerItemType.directory) {
          _moveToNextDirectory(context, file.title);
        } else {
          _previewMedia(
            context,
            file.title,
            file.id,
          );
        }
      },
    );
  }

  void _moveToNextDirectory(BuildContext context, String directoryName) =>
      AutoRouter.of(context).push(
        FileExplorerRoute(path: '$path$directoryName/'),
      );

  void _previewMedia(
    BuildContext context,
    String resourceName,
    String? pubId,
  ) =>
      AutoRouter.of(context).push(
        MediaReaderRoute(
          path: path,
          resourceName: resourceName,
          resourcePubId: pubId,
        ),
      );
}
