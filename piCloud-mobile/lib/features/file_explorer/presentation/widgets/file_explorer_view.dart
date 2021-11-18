import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/selection/selected_item_frame.dart';
import 'package:app/features/loadingBaner/presentation/loading_panel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_explorer_item/file_explorer_list_item.dart';

class FileExplorerView extends StatefulWidget {
  final Function(Selection) selectionChanged;
  final String path;

  FileExplorerView({
    Key? key,
    required this.path,
    required this.selectionChanged,
  }) : super(key: key);

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

    this._gridViewController.addListener(
          () => this.widget.selectionChanged(this._gridViewController.value),
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
    return Container(
      child: BlocProvider.value(
        value: this._bloc,
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
                        child: _buildFileExplorerView(snapshot.data as bool),
                        onRefresh: _refreshData,
                      );
                    } else {
                      return LoadingPanel();
                    }
                  },
                );
              } else if (state is FetchingDataErrorFileExplorerState) {
                return FileExplorerErrorWidget(
                  errorMessage: "Check your internet connection.",
                );
              } else {
                return LoadingPanel();
              }
            },
          ),
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
      radius: Radius.circular(5.0),
      controller: _scrollController,
      child: DragSelectGridView(
        triggerSelectionOnTap: false,
        gridController: this._gridViewController,
        padding: EdgeInsets.all(8),
        itemCount: directoryContent.length,
        itemBuilder: (context, index, selected) {
          FileExplorerItem currentItem = directoryContent[index];

          if (selected) {
            return SelectedItemFrame(item: currentItem);
          } else {
            return GestureDetector(
              onTap: () {
                if (currentItem.file.type == FileExplorerItemType.DIRECTORY) {
                  _moveToNextDirectory(currentItem.file.title);
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
    List<FileExplorerItem> items = <FileExplorerItem>[];

    if (this._bloc.directoryContent == null) {
      return items;
    } else {
      this._bloc.directoryContent!.forEach(
            (FileItem item) => items.add(FileExplorerItem(file: item)),
          );

      return items;
    }
  }

  Future<bool> _checkIfPreferredViewIsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("preferredView") == "list";
  }

  List<FileExplorerListItem> _getItemWidgetsListForListView() {
    List<FileExplorerListItem> items = <FileExplorerListItem>[];

    if (this._bloc.directoryContent == null) {
      return items;
    } else {
      this._bloc.directoryContent!.forEach(
            (FileItem item) => items.add(FileExplorerListItem(file: item)),
          );

      items.sort(
        (FileExplorerListItem a, FileExplorerListItem b) =>
            a.file.type.index - b.file.type.index,
      );

      return items;
    }
  }

  void _moveToNextDirectory(String directoryName) =>
      AutoRouter.of(context).push(
        FileExplorerRoute(path: this.widget.path + directoryName + "/"),
      );

  Future<void> _refreshData() async => setState(() {
        this._bloc.close();
        _initializeBloc();
      });

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
              FetchDataErrorOccuredFileExplorerEvent(
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
    this._bloc = FileExplorerBloc(path: widget.path);
    this._bloc.add(FetchDataFileExplorerEvent(path: widget.path));
  }
}
