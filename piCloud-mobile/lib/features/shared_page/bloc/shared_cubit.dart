import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/shared_page/data/shared_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit({
    String? path,
    required ViewModeCubit viewModeCubit,
    required SharedManager sharedManager,
    required DirectoryManager directoryManager,
  })  : _path = path,
        _viewModeCubit = viewModeCubit,
        _sharedManager = sharedManager,
        _directoryManager = directoryManager,
        super(const SharedInitialState());

  final String? _path;
  final ViewModeCubit _viewModeCubit;
  final SharedManager _sharedManager;
  final DirectoryManager _directoryManager;

  Future<void> fetch() async {
    final path = _path;

    emit(const SharedLoadingState());

    try {
      final List<FileItem> files;

      if (path == null) {
        files = await _sharedManager.getCurrentDirectoryItems() ?? [];
      } else {
        files = await _directoryManager.getCurrentDirectoryItems(path) ?? [];
      }

      if (_viewModeCubit.state == ViewMode.list) {
        emit(
          SharedReadyState(
            files..sort((a, b) => a.type.index - b.type.index),
          ),
        );
      } else {
        emit(SharedReadyState(files));
      }
    } catch (exception) {
      emit(const SharedErrorState('Failed to fetch data.'));
    }
  }
}
