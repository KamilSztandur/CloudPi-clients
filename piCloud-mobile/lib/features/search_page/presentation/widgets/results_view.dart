import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item/file_explorer_list_item.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/data/search_engine.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({
    Key? key,
    required this.query,
    required this.filters,
  }) : super(key: key);

  final FiltersSettingsModel filters;
  final SearchQueryModel? query;

  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final ScrollController _scrollController = ScrollController();
  final SearchEngine _searchEngine = SearchEngine();

  @override
  Widget build(BuildContext context) {
    if (widget.query == null) {
      return _buildNoResultsLabel();
    } else {
      return Column(
        children: [
          _buildSearchResultsHeader(),
          Expanded(child: _buildResultsListView()),
        ],
      );
    }
  }

  Widget _buildSearchResultsHeader() => Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(0, 0.3),
            ),
          ],
        ),
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

  Widget _buildResultsListView() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: _searchEngine.getFilteredResultsForQuery(
          widget.query!,
          widget.filters,
        ),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final results = snapshot.data! as List<SearchResult>;

            if (results.isEmpty) {
              return _buildNoResultsLabel();
            } else {
              return _buildResultsList(results);
            }
          } else {
            return _buildSearchingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildResultsList(List<SearchResult> results) => RawScrollbar(
        thickness: 7.5,
        isAlwaysShown: true,
        thumbColor: Theme.of(context).primaryColorDark,
        radius: const Radius.circular(5),
        controller: _scrollController,
        child: DragSelectGridView(
          scrollController: _scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: results.length,
          itemBuilder: (context, index, selected) => _buildResultsListItem(
            results[index],
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            mainAxisExtent: 90,
          ),
        ),
      );

  Widget _buildSearchingIndicator() {
    final size = MediaQuery.of(context).size.shortestSide * 0.75;

    return Center(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColorDark,
                strokeWidth: 2,
              ),
            ),
          ),
          Center(
            child: Text(
              'Searching...',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsListItem(SearchResult item) => FileExplorerListItem(
        file: _searchEngine.parseSearchResultIntoFileItem(item),
      );
}
