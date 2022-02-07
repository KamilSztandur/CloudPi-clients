import 'dart:typed_data';

import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_reader_event.dart';
part 'media_reader_state.dart';

class MediaReaderBloc extends Bloc<MediaReaderEvent, MediaReaderState> {
  MediaReaderBloc() : super(const InitialState());

  final MediaReaderService service = MediaReaderService();

  @override
  Stream<MediaReaderState> mapEventToState(MediaReaderEvent event) async* {
    if (event is RequestMediaDownloadEvent) {
      yield* _getFromURI(event);
    }
  }

  Stream<MediaReaderState> _getFromURI(RequestMediaDownloadEvent event) async* {
    yield DownloadingMediaState(resource: event.resource);

    try {
      final mediaBytes = await service.downloadBytes(event.resource);

      yield MediaDownloadSuccessState(resourceBytes: mediaBytes);
    } catch (exception) {
      yield MediaDownloadFailureState(errorMessage: exception.toString());
    }
  }
}
