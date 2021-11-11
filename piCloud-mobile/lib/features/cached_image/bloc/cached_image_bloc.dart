import 'package:app/features/cached_image/data/image_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cached_image_event.dart';
part 'cached_image_state.dart';

class CachedImageBloc extends Bloc<CachedImageEvent, CachedImageState> {
  late ImageManager _imageManager = ImageManager();
  final String url;
  int? width, height;
  Image? _image, _originalImage;

  CachedImageBloc({
    required this.url,
    this.width,
    this.height,
  }) : super(CachedImageInitialState());

  @override
  Stream<CachedImageState> mapEventToState(CachedImageEvent event) async* {
    if (event is InitializeCachedImageEvent) {
      yield CachedImageInitialState();
    } else if (event is FetchCachedImageEvent) {
      yield* _fetchCachedImageEvent(event);
    } else if (event is FetchingCachedImageErrorEvent) {
      yield* _fetchCachedImageErrorEvent(event);
    } else if (event is FetchingCachedImageFinishedEvent) {
      yield* _fetchCachedImageSuccessEvent(event);
    }
  }

  Stream<CachedImageState> _fetchCachedImageEvent(
    FetchCachedImageEvent event,
  ) async* {
    yield FetchingCachedImageState();

    try {
      this._originalImage = await this._imageManager.fetchImageFromBackend(
            this.url,
          );

      this._image = await this._imageManager.resizeMemoryImage(
            this._originalImage!,
            this.height,
            this.width,
          );

      yield CachedImageFetchedState(image: this._image!);
    } catch (exception) {
      yield CachedImageFetchingFailureState();
    }
  }

  Stream<CachedImageState> _fetchCachedImageErrorEvent(
    FetchingCachedImageErrorEvent event,
  ) async* {
    yield CachedImageFetchingFailureState();
  }

  Stream<CachedImageState> _fetchCachedImageSuccessEvent(
    FetchingCachedImageFinishedEvent event,
  ) async* {
    yield CachedImageFetchedState(image: this._image!);
  }
}
