import 'package:app/common/widgets/error_view.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/add_media_floating_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_selection_app_bar.dart';
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
  var _selection = const Selection.empty();
  late FileExplorerBloc _bloc;

  @override
  void initState() {
    _bloc = FileExplorerBloc(
      path: widget.path,
      viewModeCubit: context.read(),
      directoryManager: context.read(),
    )..add(const FetchDataFileExplorerEvent());

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<FileExplorerBloc, FileExplorerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(context, state),
            drawer: const MainDrawer(),
            body: RefreshIndicator(
              onRefresh: () async => _refreshData(),
              child: _buildBody(state),
            ),
            floatingActionButton: _getAddMediaButtonIfNeeded(context),
            bottomNavigationBar: const PICloudBottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget _buildBody(FileExplorerState state) {
    if (state is FetchedDataFileExplorerState) {
      return FileExplorerView(
        path: widget.path,
        files: state.files,
        onSelectionChanged: (selection) => setState(() {
          _selection = selection;
        }),
        onActionFinalized: _refreshData,
      );
    } else if (state is FetchingDataErrorFileExplorerState) {
      return const ErrorView(
        errorMessage: 'Check your internet connection.',
      );
    } else {
      return const LoadingPanel();
    }
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    FileExplorerState state,
  ) {
    if (state is FetchedDataFileExplorerState && _selection.isSelecting) {
      return FileExplorerSelectionAppBar(
        selection: _selection,
        allItems: state.files,
        currentDirPath: widget.path,
        onActionFinalized: () => _onSelectionActionFinalized(context),
      );
    } else {
      return PICloudAppBar(
        title: _getTitle(),
        actions: const [SwitchViewButton()],
      );
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

  void _onSelectionActionFinalized(BuildContext context) {
    _selection = const Selection.empty();
    _refreshData();
  }

  Widget _getAddMediaButtonIfNeeded(BuildContext context) {
    return (_selection.isSelecting)
        ? const SizedBox()
        : AddMediaButton(
            currentPath: widget.path,
            onNewMediaAdded: _refreshData,
          );
  }

  void _refreshData() {
    _bloc.add(const FetchDataFileExplorerEvent());
  }
}
