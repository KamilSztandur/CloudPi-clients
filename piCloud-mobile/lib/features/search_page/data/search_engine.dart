import 'dart:convert';
import 'dart:io';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

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
      final searchResult = await _readSearchResultsList(response);

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

  FileItem parseSearchResultIntoFileItem(SearchResult result) => FileItem(
        title: result.title,
        lastModifiedOn: result.lastModifiedOn,
        type: result.type,
        size: result.size,
        id: result.id,
        thumbnail: result.thumbnail,
        isFavorite: null,
        permissions: {},
      );

  Future<List<SearchResult>> _readSearchResultsList(
    StreamedResponse response,
  ) async {
    final items = <SearchResult>[];

    final responseItems = json.decode(
      await response.stream.bytesToString(),
    ) as List<dynamic>;

    for (final item in responseItems) {
      final data = item as Map<String, dynamic>;

      final parsedItem = SearchResult(
        title: data['name'] as String,
        lastModifiedOn: DateTime.parse(data['modifiedAt'] as String),
        type: _getFileTypeFromString(data['type'] as String),
        size: (data['size'] as int).toDouble(),
        thumbnail: null,
        id: data['pubId'] as String,
      );

      items.add(parsedItem);
    }

    return items;
  }

  Future<String> _getJSONEncodedBody(
    SearchQueryModel query,
    FiltersSettingsModel filters,
  ) async {
    final username = await _authManager.getUsernameOfLoggedUser();

    final path = (filters.range != SearchRange.everywhere && query.path != null)
        ? '$username${query.path}'
        : await _getUsersHomeDirectoryPath();

    final body = json.encode({
      'name': query.name,
      'path': path,
      'types': _getAllowedTypesList(filters),
      'lastModified': {
        'from': _getFormattedDate(filters.minDate!),
        'to': _getFormattedDate(filters.maxDate!),
      },
    });

    return body;
  }

  String _getFormattedDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.000');
    final formattedDate = '${formatter.format(date)}Z';

    return formattedDate;
  }

  Future<String> _getUsersHomeDirectoryPath() async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final homePath = '$username/';

    return homePath;
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
        case FileExplorerItemType.compressed:
          if (value == true) {
            allowedFileTypes.add('COMPRESSED');
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

  FileExplorerItemType _getFileTypeFromString(String data) {
    if (data.contains('DIRECTORY')) {
      return FileExplorerItemType.directory;
    } else if (data.contains('IMAGE')) {
      return FileExplorerItemType.image;
    } else if (data.contains('VIDEO')) {
      return FileExplorerItemType.video;
    } else if (data.contains('MUSIC')) {
      return FileExplorerItemType.music;
    } else if (data.contains('PDF')) {
      return FileExplorerItemType.pdf;
    } else if (data.contains('TEXT_FILE')) {
      return FileExplorerItemType.text;
    } else if (data.contains('COMPRESSED')) {
      return FileExplorerItemType.compressed;
    } else {
      return FileExplorerItemType.file;
    }
  }

  Future<String> getFilePathFromPubId(String pubId) async {
    final headers = await _getHeaders();

    final request = http.Request(
      'GET',
      Uri.parse(
        '${Config.apiBaseUrl}/filesystem/file/$pubId',
      ),
    );

    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(
        await response.stream.bytesToString(),
      ) as Map<String, dynamic>;

      final path = data['path'] as String;

      return path;
    } else {
      throw HttpException(
        'File info fetching failed (${response.statusCode}).',
      );
    }
  }
}
