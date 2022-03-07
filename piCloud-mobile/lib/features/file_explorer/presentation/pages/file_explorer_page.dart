import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/app_bar/selection_app_bar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/add_media_floating_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_view.dart';
import 'package:app/features/file_explorer/presentation/widgets/switch_view_button.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FileExplorerPage extends StatefulWidget {
  const FileExplorerPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> {
  late FileExplorerBloc _bloc;
  Selection? selection;
  late List<FileExplorerItem> items;

  @override
  void initState() {
    _initializeBloc();

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
              return _getScaffold(
                child: FileExplorerView(
                  path: widget.path,
                  setItems: (items) => this.items = items,
                  selectionChanged: (selection) => setState(() {
                    this.selection = selection;
                  }),
                  directoryContent: _bloc.directoryContent,
                ),
              );
            } else if (state is FetchingDataErrorFileExplorerState) {
              return _getScaffold(
                child: const FileExplorerErrorWidget(
                  errorMessage: 'Check your internet connection.',
                ),
              );
            } else {
              return _getScaffold(child: const LoadingPanel());
            }
          },
        ),
      ),
    );
  }

  Widget _getScaffold({required Widget child}) {
    return Scaffold(
      appBar: _getBar(context.read<Api>()),
      drawer: const MainDrawer(),
      body: RefreshIndicator(onRefresh: _refreshData, child: child),
      floatingActionButton: _getAddMediaButtonIfNeeded(),
      bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }

  bool _isSelecting() {
    if (selection != null && selection!.amount > 0) {
      return true;
    } else {
      return false;
    }
  }

  String _getTitle() {
    if (widget.path == '/') {
      return 'Files';
    } else {
      var directoryName = widget.path.substring(0, widget.path.length - 1);
      directoryName = directoryName.split('/').last;

      return directoryName;
    }
  }

  PreferredSizeWidget _getBar(Api api) {
    if (_isSelecting()) {
      return SelectionAppBar(
        selection: selection ?? DragSelectGridViewController().value,
        allItems: items,
        currentDirPath: widget.path,
        onActionFinalized: _onSelectionActionFinalized,
      );
    } else {
      return PICloudAppBar(
        title: _getTitle(),
        actions: [
          SwitchViewButton(
            viewSwitched: () => setState(() {}),
          ),
        ],
      );
    }
  }

  void _onSelectionActionFinalized() {
    selection = null;
    _refreshData();
  }

  Widget _getAddMediaButtonIfNeeded() {
    return (selection != null && selection!.amount > 0)
        ? const SizedBox()
        : AddMediaButton(
            currentPath: widget.path,
            onNewMediaAdded: _refreshData,
          );
  }

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
