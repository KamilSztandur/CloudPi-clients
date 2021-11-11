part of 'cached_image_bloc.dart';

abstract class CachedImageState extends Equatable {
  const CachedImageState();

  @override
  List<Object> get props => [];
}

class CachedImageInitialState extends CachedImageState {
  @override
  List<Object> get props => [];
}

class FetchingCachedImageState extends CachedImageState {
  @override
  List<Object> get props => [];
}

class CachedImageFetchedState extends CachedImageState {
  final Image image;

  CachedImageFetchedState({
    required this.image,
  });

  @override
  List<Object> get props => [this.image];
}

class CachedImageFetchingFailureState extends CachedImageState {
  @override
  List<Object> get props => [];
}
