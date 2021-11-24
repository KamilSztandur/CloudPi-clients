import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/presentation/widgets/results_view.dart';
import 'package:app/features/search_page/presentation/widgets/search_page_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchQueryModel? _query;
  late FiltersSettingsModel _filters;

  @override
  void initState() {
    _filters = FiltersSettingsModel.withDefaultSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPageBar(
        queryRequested: _handleQueryRequest,
        onFiltersChanged: (filters) => _filters = filters,
        currentFilters: _filters,
      ),
      body: Stack(
        children: [
          ResultsView(
            query: _query,
            filters: _filters,
          ),
        ],
      ),
    );
  }

  void _handleQueryRequest(SearchQueryModel query) => setState(() {
        _query = query;
      });
}
