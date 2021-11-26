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
  const SearchingSearchState({
    required this.filters,
    required this.query,
  });

  final FiltersSettingsModel filters;
  final SearchQueryModel query;

  @override
  List<Object> get props => [query, filters];
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
  const SearchFinishedSearchState({
    required this.filters,
    required this.query,
    required this.results,
  });

  final FiltersSettingsModel filters;
  final SearchQueryModel query;
  final List<SearchResult> results;

  @override
  List<Object> get props => [query, filters, results];
}

class SearchFinishedButNoResultsFoundSearchState extends SearchState {
  const SearchFinishedButNoResultsFoundSearchState({
    required this.filters,
    required this.query,
  });

  final FiltersSettingsModel filters;
  final SearchQueryModel query;

  @override
  List<Object> get props => [query, filters];
}
