import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/data/search_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState());

  final SearchEngine _searchEngine = SearchEngine();
  List<SearchResult>? _results;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is InitializeSearchEvent) {
      yield InitialSearchState();
    } else if (event is QueryRequestedSearchEvent) {
      yield* _executeQuery(event);
    } else if (event is SearchingErrorSearchEvent) {
      yield* _onQueryError(event);
    } else if (event is SearchingFinishedSearchEvent) {
      yield* _onQueryDone(event);
    } else if (event is SearchingFinishedButNoResultsFoundSearchEvent) {
      yield* _onQueryNoResultsFound(event);
    }
  }

  Stream<SearchState> _executeQuery(QueryRequestedSearchEvent event) async* {
    yield SearchingSearchState();

    try {
      _results = await _searchEngine.getFilteredResultsForQuery(
        event.query,
        event.filters,
      );

      if (_results!.isEmpty) {
        yield SearchFinishedButNoResultsFoundSearchState();
      } else {
        yield SearchFinishedSearchState();
      }
    } catch (exception) {
      yield const SearchErrorSearchState(message: 'Searching failed');
    }
  }

  Stream<SearchState> _onQueryError(SearchingErrorSearchEvent event) async* {
    yield const SearchErrorSearchState(message: 'Searching failed');
  }

  Stream<SearchState> _onQueryDone(SearchingFinishedSearchEvent event) async* {
    yield SearchFinishedSearchState();
  }

  Stream<SearchState> _onQueryNoResultsFound(
    SearchingFinishedButNoResultsFoundSearchEvent event,
  ) async* {
    yield SearchFinishedButNoResultsFoundSearchState();
  }

  List<SearchResult> getResults() => _results ?? <SearchResult>[];
}
