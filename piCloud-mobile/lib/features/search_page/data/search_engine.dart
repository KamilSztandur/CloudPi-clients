import 'dart:math';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
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

  // WARNING: Mock
  Future<List<SearchResult>> _getRawList(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final items = <SearchResult>[];

    for (var i = 0; i < 10; i++) {
      final currentType = FileExplorerItemType.values[Random().nextInt(
        FileExplorerItemType.values.length,
      )];

      var title = currentType.toString();
      title = '${title.substring(title.indexOf('.') + 1, title.length)} $i';
      title = title[0] + title.substring(1).toLowerCase();

      items.add(
        SearchResult(
          title: title,
          lastModifiedOn: DateTime.now(),
          type: currentType,
          size: 20,
          thumbnailURL: null,
        ),
      );
    }

    items.add(
      SearchResult(
        title: 'Francuskie zamki długa nazwa',
        lastModifiedOn: DateTime.now(),
        type: FileExplorerItemType.image,
        size: 20,
        thumbnailURL:
            'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg',
      ),
    );

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
        thumbnailURL: result.thumbnailURL,
      );
}
