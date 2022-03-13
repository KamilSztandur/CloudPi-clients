part of 'shared_cubit.dart';

abstract class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

class SharedInitialState extends SharedState {
  const SharedInitialState();

  @override
  List<Object> get props => [];
}

class SharedLoadingState extends SharedState {
  const SharedLoadingState();

  @override
  List<Object> get props => [];
}

class SharedReadyState extends SharedState {
  const SharedReadyState(this.files);

  final List<FileItem> files;

  @override
  List<Object> get props => [];
}

class SharedErrorState extends SharedState {
  const SharedErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
