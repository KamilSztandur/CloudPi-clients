import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({
    Key? key,
    required this.results,
    required this.query,
  }) : super(key: key);

  final List<SearchResult>? results;
  final SearchQueryModel? query;

  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  @override
  Widget build(BuildContext context) {
    if (widget.results != null && widget.results!.isNotEmpty) {
      return _buildBody();
    } else {
      return _buildNoResultsLabel();
    }
  }

  Widget _buildBody() => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildSearchResultsHeader(),
          ),
        ],
      );

  Widget _buildSearchResultsHeader() => Padding(
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
                text: widget.query!.name,
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

  Widget _buildNoResultsLabel() {
    final size = MediaQuery.of(context).size.shortestSide * 0.6;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.35),
        ),
        padding: EdgeInsets.all(size * 0.15),
        height: size,
        width: size,
        child: const FittedBox(
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
