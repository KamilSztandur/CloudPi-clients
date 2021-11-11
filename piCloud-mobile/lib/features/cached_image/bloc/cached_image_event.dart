part of 'cached_image_bloc.dart';

abstract class CachedImageEvent extends Equatable {
  const CachedImageEvent();

  @override
  List<Object> get props => [];
}

class InitializeCachedImageEvent extends CachedImageEvent {
  @override
  List<Object> get props => [];
}

class FetchCachedImageEvent extends CachedImageEvent {
  @override
  List<Object> get props => [];
}

class FetchingCachedImageErrorEvent extends CachedImageEvent {
  @override
  List<Object> get props => [];
}

class FetchingCachedImageFinishedEvent extends CachedImageEvent {
  @override
  List<Object> get props => [];
}
