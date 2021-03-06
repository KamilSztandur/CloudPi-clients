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
    required this.shared,
    required this.onSelectionChanged,
    required this.onActionFinalized,
  }) : super(key: key);

  final String path;
  final List<FileItem> files;
  final bool shared;
  final ValueChanged<Selection> onSelectionChanged;
  final VoidCallback onActionFinalized;

  @override
  Widget build(BuildContext context) {
    return FilesView(
      files: files,
      onSelectionChanged: onSelectionChanged,
      onFileTapped: (file) {
        if (file.type == FileExplorerItemType.directory) {
          _moveToNextDirectory(context, file.title);
        } else {
          _previewMedia(context, file, shared);
        }
      },
    );
  }

  void _moveToNextDirectory(BuildContext context, String directoryName) =>
      AutoRouter.of(context).push(
        FileExplorerRoute(path: '$path$directoryName/'),
      );

  void _previewMedia(BuildContext context, FileItem item, bool shared) =>
      AutoRouter.of(context).push(
        MediaReaderRoute(
          path: path,
          item: item,
          permissions: item.permissions,
          shared: shared,
          onActionFinalized: onActionFinalized,
        ),
      );
}
