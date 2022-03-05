part of 'file_explorer_bloc.dart';

abstract class FileExplorerEvent extends Equatable {
  const FileExplorerEvent();

  @override
  List<Object> get props => [];
}

class FetchDataFileExplorerEvent extends FileExplorerEvent {
  const FetchDataFileExplorerEvent();

  @override
  List<Object> get props => [];
}
