part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();

  @override
  List<Object> get props => [];
}

class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();

  @override
  List<Object> get props => [];
}

class FavoritesReadyState extends FavoritesState {
  const FavoritesReadyState(this.files);

  final List<FileItem> files;

  @override
  List<Object> get props => [];
}

class FavoritesErrorState extends FavoritesState {
  const FavoritesErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
