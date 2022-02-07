part of 'media_reader_bloc.dart';

abstract class MediaReaderEvent extends Equatable {
  const MediaReaderEvent();

  @override
  List<Object> get props => [];
}

class RequestMediaDownloadEvent extends MediaReaderEvent {
  const RequestMediaDownloadEvent({
    required this.resource,
  });

  final Uri resource;

  @override
  List<Object> get props => [resource];
}
