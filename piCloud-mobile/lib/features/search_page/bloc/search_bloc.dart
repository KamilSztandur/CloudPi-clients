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

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is InitializeSearchEvent) {
      yield InitialSearchState();
    } else if (event is QueryRequestedSearchEvent) {
      yield* _executeQuery(event);
    }
  }

  Stream<SearchState> _executeQuery(QueryRequestedSearchEvent event) async* {
    try {
      yield SearchingSearchState(query: event.query, filters: event.filters);

      try {
        final results = await _searchEngine.getFilteredResultsForQuery(
          event.query,
          event.filters,
        );

        if (results.isEmpty) {
          yield SearchFinishedButNoResultsFoundSearchState(
            query: event.query,
            filters: event.filters,
          );
        } else {
          yield SearchFinishedSearchState(
            query: event.query,
            filters: event.filters,
            results: results,
          );
        }
      } catch (exception) {
        yield const SearchErrorSearchState(message: 'Searching failed.');
      }
    } catch (exception) {
      yield const SearchErrorSearchState(
        message: 'Could not load query params.',
      );
    }
  }
}
