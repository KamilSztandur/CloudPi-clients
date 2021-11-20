part of 'file_explorer_bloc.dart';

abstract class FileExplorerEvent extends Equatable {
  const FileExplorerEvent();

  @override
  List<Object> get props => [];
}

class InitializeFileExplorerEvent extends FileExplorerEvent {
  @override
  List<Object> get props => [];
}

class FetchDataFileExplorerEvent extends FileExplorerEvent {
  const FetchDataFileExplorerEvent({
    required this.path,
  });

  final String path;

  @override
  List<Object> get props => [path];
}

class FetchDataErrorOccurredFileExplorerEvent extends FileExplorerEvent {
  const FetchDataErrorOccurredFileExplorerEvent({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class FetchingDataFinishedFileExplorerEvent extends FileExplorerEvent {
  @override
  List<Object> get props => [];
}
