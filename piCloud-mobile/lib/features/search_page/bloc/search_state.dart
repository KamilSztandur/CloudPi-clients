part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchingSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchErrorSearchState extends SearchState {
  const SearchErrorSearchState({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

class SearchFinishedSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchFinishedButNoResultsFoundSearchState extends SearchState {
  @override
  List<Object> get props => [];
}
