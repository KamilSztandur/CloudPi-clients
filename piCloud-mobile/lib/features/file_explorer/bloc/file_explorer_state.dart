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

class FetchningDataFileExplorerState extends FileExplorerState {
  @override
  List<Object> get props => [];
}

class FetchedDataFileExplorerState extends FileExplorerState {
  @override
  List<Object> get props => [];
}

class FetchingDataErrorFileExplorerState extends FileExplorerState {
  final String errorMessage;

  FetchingDataErrorFileExplorerState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [this.errorMessage];
}
