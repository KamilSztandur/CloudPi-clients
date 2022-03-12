part of 'media_reader_bloc.dart';

abstract class MediaReaderState extends Equatable {
  const MediaReaderState();

  @override
  List<Object> get props => [];
}

class InitialState extends MediaReaderState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class DownloadingMediaState extends MediaReaderState {
  const DownloadingMediaState({
    required this.resourcePubId,
  });

  final String resourcePubId;

  @override
  List<Object> get props => [resourcePubId];
}

class MediaDownloadSuccessState extends MediaReaderState {
  const MediaDownloadSuccessState({
    required this.resourceBytes,
  });

  final Uint8List resourceBytes;

  @override
  List<Object> get props => [resourceBytes];
}

class MediaDownloadFailureState extends MediaReaderState {
  const MediaDownloadFailureState({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
