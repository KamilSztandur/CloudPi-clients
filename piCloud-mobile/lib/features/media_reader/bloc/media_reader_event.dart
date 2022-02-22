part of 'media_reader_bloc.dart';

abstract class MediaReaderEvent extends Equatable {
  const MediaReaderEvent();

  @override
  List<Object> get props => [];
}

class RequestMediaDownloadEvent extends MediaReaderEvent {
  const RequestMediaDownloadEvent({
    required this.resourcePubId,
  });

  final String resourcePubId;

  @override
  List<Object> get props => [resourcePubId];
}

class DetectedDamagedFileEvent extends MediaReaderEvent {
  const DetectedDamagedFileEvent();

  @override
  List<Object> get props => [];
}
