import 'package:app/features/search_page/data/models/search_query_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPageBar(queryRequested: _handleQueryRequest),
      body: Stack(
        children: [
          Container(),
          if (_query != null)
            Align(
              alignment: Alignment.topCenter,
              child: _buildSearchResultsHeader(),
            ),
        ],
      ),
    );
  }

  void _handleQueryRequest(SearchQueryModel query) {
    //TODO

    setState(() {
      _query = query;
    });
  }

  Widget _buildSearchResultsHeader() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          text: 'Search results for\n',
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColorDark,
          ),
          children: <TextSpan>[
            TextSpan(
              text: _query!.name,
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
