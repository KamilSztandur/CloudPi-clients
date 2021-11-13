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
  final String path;

  FetchDataFileExplorerEvent({
    required this.path,
  });

  @override
  List<Object> get props => [this.path];
}

class FetchDataErrorOccuredFileExplorerEvent extends FileExplorerEvent {
  final String errorMessage;

  FetchDataErrorOccuredFileExplorerEvent({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [this.errorMessage];
}

class FetchingDataFinishedFileExplorerEvent extends FileExplorerEvent {
  @override
  List<Object> get props => [];
}
