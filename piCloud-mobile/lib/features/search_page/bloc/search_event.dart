part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class InitializeSearchEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}

class QueryRequestedSearchEvent extends SearchEvent {
  const QueryRequestedSearchEvent({
    required this.query,
    required this.filters,
  });

  final SearchQueryModel query;
  final FiltersSettingsModel filters;

  @override
  List<Object> get props => [query, filters];
}
