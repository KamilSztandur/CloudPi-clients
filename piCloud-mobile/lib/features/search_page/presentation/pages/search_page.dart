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
  List<SearchResult>? _results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPageBar(queryRequested: _handleQueryRequest),
      body: Stack(
        children: [
          ResultsView(
            results: _results,
            query: _query,
          ),
        ],
      ),
    );
  }

  void _handleQueryRequest(SearchQueryModel query) {
    //TODO

    setState(() {
      _query = query;
      _results = <SearchResult>[SearchResult()];
    });
  }
}
