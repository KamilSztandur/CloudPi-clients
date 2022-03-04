import 'dart:convert';
import 'dart:io';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SearchEngine {
  const SearchEngine(
    this._authManager,
  );

  final AuthManager _authManager;

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

  Future<List<SearchResult>> _getRawList(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    final request = http.Request(
      'POST',
      Uri.parse('${Config.apiBaseUrl}/filesystem/search'),
    )..body = await _getJSONEncodedBody(query, filters);

    request.headers.addAll(await _getHeaders());

    final response = await request.send();

    if (response.statusCode == 200) {
      final searchResult = _readSearchResultsList(response);

      return searchResult;
    } else {
      throw HttpException('Search failed (${response.statusCode}).');
    }
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

  FileItem _parseSearchResultIntoFileItem(SearchResult result) => FileItem(
        title: result.title,
        lastModifiedOn: result.lastModifiedOn,
        type: result.type,
        size: result.size,
        id: result.id,
        thumbnail: result.thumbnail,
      );

  List<SearchResult> _readSearchResultsList(StreamedResponse response) {
    final items = <SearchResult>[];

    return items;
  }

  Future<String> _getJSONEncodedBody(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final body = json.encode({
      'name': query.name,
      'path': '$username/',
      'types': _getAllowedTypesList(filters),
      'created': {
        'from': filters.minDate.toString(),
        'to': filters.maxDate.toString(),
      },
    });
    print(body);
    return body;
  }

  List<String> _getAllowedTypesList(FiltersSettingsModel filters) {
    final allowedFileTypes = <String>[];

    filters.allowedFileTypes!.forEach((key, value) {
      switch (key) {
        case FileExplorerItemType.directory:
          if (value == true) {
            allowedFileTypes.add('DIRECTORY');
          }
          break;
        case FileExplorerItemType.image:
          if (value == true) {
            allowedFileTypes.add('IMAGE');
          }
          break;
        case FileExplorerItemType.video:
          if (value == true) {
            allowedFileTypes.add('VIDEO');
          }
          break;
        case FileExplorerItemType.music:
          if (value == true) {
            allowedFileTypes.add('MUSIC');
          }
          break;
        case FileExplorerItemType.pdf:
          if (value == true) {
            allowedFileTypes.add('PDF');
          }
          break;
        case FileExplorerItemType.text:
          if (value == true) {
            allowedFileTypes.add('TEXT_FILE');
          }
          break;
        default:
          if (value == true) {
            allowedFileTypes.add('UNDEFINED');
          }
          break;
      }
    });

    return allowedFileTypes;
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authManager.getAccessToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return headers;
  }
}
