import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/file_permission.dart';
import 'package:app/common/widgets/error_view.dart';
import 'package:app/common/widgets/files_view/files_view.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_selection_app_bar.dart';
import 'package:app/features/file_explorer/presentation/widgets/switch_view_button.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/shared_page/bloc/shared_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({
    Key? key,
    this.path,
  }) : super(key: key);

  final String? path;

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  var _selection = const Selection.empty();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SharedCubit(
        path: widget.path,
        viewModeCubit: context.read(),
        sharedManager: context.read(),
        directoryManager: context.read(),
      )..fetch(),
      child: BlocBuilder<SharedCubit, SharedState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(context, state),
            drawer: const MainDrawer(),
            body: RefreshIndicator(
              onRefresh: () async => _refreshData(),
              child: _buildBody(state),
            ),
            bottomNavigationBar: const PICloudBottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget _buildBody(SharedState state) {
    if (state is SharedReadyState) {
      return FilesView(
        files: state.files,
        onSelectionChanged: (selection) => setState(() {
          _selection = selection;
        }),
        onFileTapped: (file) {
          if (file.type == FileExplorerItemType.directory) {
            _moveToNextDirectory(context, file.title);
          } else {
            _previewMedia(context, file);
          }
        },
      );
    } else if (state is SharedErrorState) {
      return const ErrorView(
        errorMessage: 'Check your internet connection.',
      );
    } else {
      return const LoadingPanel();
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, SharedState state) {
    if (state is SharedReadyState && _selection.isSelecting) {
      return FileExplorerSelectionAppBar(
        selection: _selection,
        allItems: state.files,
        currentDirPath: widget.path ?? '/',
        shared: true,
        onActionFinalized: () => _onSelectionActionFinalized(context),
      );
    } else {
      return const PICloudAppBar(
        title: 'Shared',
        actions: [SwitchViewButton()],
      );
    }
  }

  void _onSelectionActionFinalized(BuildContext context) {
    _selection = const Selection.empty();
    context.read<SharedCubit>().fetch();
  }

  void _moveToNextDirectory(BuildContext context, String directoryName) =>
      AutoRouter.of(context).push(
        SharedRoute(path: '${widget.path ?? '/'}$directoryName/'),
      );

  void _previewMedia(BuildContext context, FileItem item) =>
      AutoRouter.of(context).push(
        MediaReaderRoute(
          path: widget.path ?? '/', // TODO
          item: item,
          permissions: item.permissions,
          shared: true,
        ),
      );

  void _refreshData() => context.read<SharedCubit>().fetch();
}
