import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';

class SearchEngine {
  Future<List<SearchResult>> getFilteredResultsForQuery(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    final items = await _getRawList(query, filters);
    final sortedItems = _sortResultsByTypeAndName(items);

    return sortedItems;
  }

  Future<List<SearchResult>> getResultsForQuery(SearchQueryModel query) async {
    final items = await _getRawList(
      query,
      FiltersSettingsModel.withDefaultSettings(),
    );

    final sortedItems = _sortResultsByTypeAndName(items);

    return sortedItems;
  }

  //TODO
  Future<List<SearchResult>> _getRawList(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final items = <SearchResult>[];

    return items;
  }

  List<SearchResult> _sortResultsByTypeAndName(List<SearchResult> items) {
    return items
      ..sort(
        (a, b) {
          final typeComparison = a.type.index - b.type.index;
          if (typeComparison == 0) {
            return a.title.compareTo(b.title);
          } else {
            return typeComparison;
          }
        },
      );
  }

  FileItem parseSearchResultIntoFileItem(SearchResult result) => FileItem(
        title: result.title,
        lastModifiedOn: result.lastModifiedOn,
        type: result.type,
        size: result.size,
        id: result.id,
        thumbnail: result.thumbnail,
      );
}
