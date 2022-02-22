import 'dart:typed_data';

import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_reader_event.dart';
part 'media_reader_state.dart';

class MediaReaderBloc extends Bloc<MediaReaderEvent, MediaReaderState> {
  MediaReaderBloc(MediaReaderService mediaReaderService)
      : service = mediaReaderService,
        super(const InitialState());

  final MediaReaderService service;

  @override
  Stream<MediaReaderState> mapEventToState(MediaReaderEvent event) async* {
    if (event is RequestMediaDownloadEvent) {
      yield* _getFromURI(event);
    } else if (event is DetectedDamagedFileEvent) {
      yield* _detectedDamagedMedia(event);
    }
  }

  Stream<MediaReaderState> _getFromURI(RequestMediaDownloadEvent event) async* {
    yield DownloadingMediaState(resourcePubId: event.resourcePubId);

    try {
      final mediaBytes = await service.downloadBytes(event.resourcePubId);

      yield MediaDownloadSuccessState(resourceBytes: mediaBytes);
    } catch (exception) {
      yield MediaDownloadFailureState(errorMessage: exception.toString());
    }
  }

  Stream<MediaReaderState> _detectedDamagedMedia(
    DetectedDamagedFileEvent event,
  ) async* {
    yield const MediaFileDamagedState();
  }
}
