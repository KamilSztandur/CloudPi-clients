import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    String? path,
    required ViewModeCubit viewModeCubit,
    required FavoritesManager favoritesManager,
    required DirectoryManager directoryManager,
  })  : _path = path,
        _viewModeCubit = viewModeCubit,
        _favoritesManager = favoritesManager,
        _directoryManager = directoryManager,
        super(const FavoritesInitialState());

  final String? _path;
  final ViewModeCubit _viewModeCubit;
  final FavoritesManager _favoritesManager;
  final DirectoryManager _directoryManager;

  Future<void> fetch() async {
    final path = _path;

    emit(const FavoritesLoadingState());

    try {
      final List<FileItem> files;

      if (path == null) {
        files = await _favoritesManager.getCurrentDirectoryItems() ?? [];
      } else {
        files = await _directoryManager.getCurrentDirectoryItems(path) ?? [];
      }

      if (_viewModeCubit.state == ViewMode.list) {
        emit(
          FavoritesReadyState(
            files..sort((a, b) => a.type.index - b.type.index),
          ),
        );
      } else {
        emit(FavoritesReadyState(files));
      }
    } catch (exception) {
      emit(const FavoritesErrorState('Failed to fetch data.'));
    }
  }
}
