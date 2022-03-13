part of 'file_explorer_bloc.dart';

abstract class FileExplorerState extends Equatable {
  const FileExplorerState();

  @override
  List<Object> get props => [];
}

class FileExplorerInitialState extends FileExplorerState {
  @override
  List<Object> get props => [];
}

class FetchingDataFileExplorerState extends FileExplorerState {
  @override
  List<Object> get props => [];
}

class FetchedDataFileExplorerState extends FileExplorerState {
  const FetchedDataFileExplorerState(this.files);

  final List<FileItem> files;

  @override
  List<Object> get props => [];
}

class FetchingDataErrorFileExplorerState extends FileExplorerState {
  const FetchingDataErrorFileExplorerState({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
