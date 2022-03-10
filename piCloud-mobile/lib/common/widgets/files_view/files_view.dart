import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/common/widgets/files_view/file_item_view.dart';
import 'package:app/common/widgets/files_view/file_list_item_view.dart';
import 'package:app/features/file_explorer/presentation/widgets/selection/selected_item_frame.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesView extends StatefulWidget {
  const FilesView({
    Key? key,
    required this.files,
    required this.onSelectionChanged,
    required this.onFileTapped,
  }) : super(key: key);

  final List<FileItem> files;
  final ValueChanged<Selection> onSelectionChanged;
  final ValueChanged<FileItem> onFileTapped;

  @override
  _FilesViewState createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView> {
  final _gridViewController = DragSelectGridViewController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _gridViewController.addListener(
      () => widget.onSelectionChanged(_gridViewController.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = context.watch<ViewModeCubit>().state;

    final files = widget.files;

    final double maxCrossAxisExtentValue;
    final double crossAxisSpacingValue;
    final double mainAxisSpacingValue;
    final double? mainAxisExtentValue;

    if (viewMode == ViewMode.list) {
      maxCrossAxisExtentValue = 500;
      crossAxisSpacingValue = 0;
      mainAxisSpacingValue = 0;
      mainAxisExtentValue = 90;
    } else {
      maxCrossAxisExtentValue = 150;
      crossAxisSpacingValue = 8;
      mainAxisSpacingValue = 8;
      mainAxisExtentValue = null;
    }

    return files.isNotEmpty
        ? Scrollbar(
            thickness: 7.5,
            isAlwaysShown: true,
            radius: const Radius.circular(5),
            controller: _scrollController,
            child: DragSelectGridView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollController: _scrollController,
              gridController: _gridViewController,
              padding: const EdgeInsets.all(8),
              itemCount: files.length,
              itemBuilder: (context, index, selected) {
                final file = files[index];

                final fileView = viewMode == ViewMode.list
                    ? FileListItemView(file: file)
                    : FileItemView(file: file);

                if (selected) {
                  return SelectedItemFrame(child: fileView);
                } else {
                  return GestureDetector(
                    onTap: () => widget.onFileTapped(file),
                    child: fileView,
                  );
                }
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtentValue,
                crossAxisSpacing: crossAxisSpacingValue,
                mainAxisSpacing: mainAxisSpacingValue,
                mainAxisExtent: mainAxisExtentValue,
              ),
            ),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _gridViewController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
