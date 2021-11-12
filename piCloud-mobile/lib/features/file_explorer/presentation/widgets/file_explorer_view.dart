import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/selection/selected_item_frame.dart';
import 'package:app/features/loadingBaner/presentation/loading_panel.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    this._bloc = FileExplorerBloc(path: widget.path);
    this._bloc.add(FetchDataFileExplorerEvent(path: widget.path));

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
                return _buildFileExplorerView();
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

  Widget _buildFileExplorerView() {
    List<FileExplorerItem> directoryContent = _sortDirectoryItems(
      _getItemWidgetsList(),
    );

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
          if (selected) {
            return SelectedItemFrame(item: directoryContent[index]);
          } else {
            return directoryContent[index];
          }
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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

  List<FileExplorerItem> _sortDirectoryItems(List<FileExplorerItem> items) {
    List<FileExplorerItem> sortedItems = items;

    sortedItems.sort(
      (FileExplorerItem a, FileExplorerItem b) =>
          a.file.type.index - b.file.type.index,
    );

    return sortedItems;
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
}
