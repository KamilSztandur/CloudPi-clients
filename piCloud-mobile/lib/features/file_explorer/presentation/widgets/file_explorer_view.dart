import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/selection/selected_item_frame.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_explorer_item/file_explorer_list_item.dart';

class FileExplorerView extends StatefulWidget {
  const FileExplorerView({
    Key? key,
    required this.path,
    required this.selectionChanged,
    required this.setItems,
  }) : super(key: key);

  final void Function(Selection) selectionChanged;
  final String path;
  final void Function(List<FileExplorerItem>) setItems;

  @override
  _FileExplorerViewState createState() => _FileExplorerViewState();
}

class _FileExplorerViewState extends State<FileExplorerView> {
  late FileExplorerBloc _bloc;
  final _gridViewController = DragSelectGridViewController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _initializeBloc();

    _gridViewController.addListener(
      () => widget.selectionChanged(_gridViewController.value),
    );

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<FileExplorerBloc, FileExplorerState>(
        listener: _fileExplorerBlocListener,
        child: BlocBuilder<FileExplorerBloc, FileExplorerState>(
          builder: (context, state) {
            if (state is FetchedDataFileExplorerState) {
              return FutureBuilder(
                future: _checkIfPreferredViewIsList(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return RefreshIndicator(
                      onRefresh: _refreshData,
                      child: _buildFileExplorerView(snapshot.data! as bool),
                    );
                  } else {
                    return const LoadingPanel();
                  }
                },
              );
            } else if (state is FetchingDataErrorFileExplorerState) {
              return const FileExplorerErrorWidget(
                errorMessage: 'Check your internet connection.',
              );
            } else {
              return const LoadingPanel();
            }
          },
        ),
      ),
    );
  }

  Widget _buildFileExplorerView(bool displayAsListView) {
    List<FileExplorerItem> directoryContent;
    double maxCrossAxisExtentValue;
    double crossAxisSpacingValue;
    double mainAxisSpacingValue;
    double? mainAxisExtentValue;

    if (displayAsListView) {
      directoryContent = _getItemWidgetsListForListView();
      maxCrossAxisExtentValue = 500;
      crossAxisSpacingValue = 1;
      mainAxisSpacingValue = 1;
      mainAxisExtentValue = 90;
    } else {
      directoryContent = _getItemWidgetsList();
      maxCrossAxisExtentValue = 150;
      crossAxisSpacingValue = 8;
      mainAxisSpacingValue = 8;
    }

    return Scrollbar(
      thickness: 7.5,
      isAlwaysShown: true,
      radius: const Radius.circular(5),
      controller: _scrollController,
      child: DragSelectGridView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollController: _scrollController,
        gridController: _gridViewController,
        padding: const EdgeInsets.all(8),
        itemCount: directoryContent.length,
        itemBuilder: (context, index, selected) {
          final currentItem = directoryContent[index];

          if (selected) {
            return SelectedItemFrame(item: currentItem);
          } else {
            return GestureDetector(
              onTap: () {
                if (currentItem.file.type == FileExplorerItemType.directory) {
                  _moveToNextDirectory(currentItem.file.title);
                } else {
                  _previewMedia(currentItem.file.title);
                }
              },
              child: currentItem,
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
    );
  }

  List<FileExplorerItem> _getItemWidgetsList() {
    final items = <FileExplorerItem>[];

    if (_bloc.directoryContent == null) {
      return items;
    } else {
      for (final item in _bloc.directoryContent!) {
        items.add(FileExplorerItem(file: item));
      }

      widget.setItems(items);
      return items;
    }
  }

  Future<bool> _checkIfPreferredViewIsList() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('preferredView') == 'list';
  }

  List<FileExplorerListItem> _getItemWidgetsListForListView() {
    final items = <FileExplorerListItem>[];

    if (_bloc.directoryContent == null) {
      return items;
    } else {
      for (final item in _bloc.directoryContent!) {
        items.add(FileExplorerListItem(file: item));
      }

      items.sort(
        (a, b) => a.file.type.index - b.file.type.index,
      );

      widget.setItems(items);
      return items;
    }
  }

  void _moveToNextDirectory(String directoryName) =>
      AutoRouter.of(context).push(
        FileExplorerRoute(path: '${widget.path}$directoryName/'),
      );

  void _previewMedia(String resourceName) => AutoRouter.of(context).push(
        MediaReaderRoute(
          path: widget.path,
          resourceName: resourceName,
        ),
      );

  Future<void> _refreshData() async {
    setState(() {
      _bloc.close();
      _initializeBloc();
    });
  }

  void _fileExplorerBlocListener(
    BuildContext context,
    FileExplorerState state,
  ) {
    setState(() {
      if (state is FileExplorerInitialState) {
        context.read<FileExplorerBloc>().add(
              InitializeFileExplorerEvent(),
            );
      } else if (state is FetchingDataErrorFileExplorerState) {
        context.read<FileExplorerBloc>().add(
              FetchDataErrorOccurredFileExplorerEvent(
                errorMessage: state.errorMessage,
              ),
            );
      } else if (state is FetchingDataFinishedFileExplorerEvent) {
        context.read<FileExplorerBloc>().add(
              FetchingDataFinishedFileExplorerEvent(),
            );
      }
    });
  }

  void _initializeBloc() {
    _bloc = FileExplorerBloc(
      path: widget.path,
      directoryManager: context.read(),
    );
    _bloc.add(FetchDataFileExplorerEvent(path: widget.path));
  }
}
