import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  FileExplorerBloc({
    required String path,
    required ViewModeCubit viewModeCubit,
    required DirectoryManager directoryManager,
  })  : _path = path,
        _viewModeCubit = viewModeCubit,
        _directoryManager = directoryManager,
        super(FileExplorerInitialState());

  final String _path;
  final ViewModeCubit _viewModeCubit;
  final DirectoryManager _directoryManager;

  @override
  Stream<FileExplorerState> mapEventToState(FileExplorerEvent event) async* {
    if (event is FetchDataFileExplorerEvent) {
      yield* _fetchPathDataEvent();
    }
  }

  Stream<FileExplorerState> _fetchPathDataEvent() async* {
    yield FetchingDataFileExplorerState();

    try {
      final files =
          await _directoryManager.getCurrentDirectoryItems(_path) ?? [];

      if (_viewModeCubit.state == ViewMode.list) {
        yield FetchedDataFileExplorerState(
          files..sort((a, b) => a.type.index - b.type.index),
        );
      } else {
        yield FetchedDataFileExplorerState(files);
      }
    } catch (exception) {
      yield const FetchingDataErrorFileExplorerState(
        errorMessage: 'Failed to fetch data.',
      );
    }
  }
}
