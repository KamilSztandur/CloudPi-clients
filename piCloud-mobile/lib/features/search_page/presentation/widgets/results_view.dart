import 'package:app/features/search_page/bloc/search_bloc.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:app/features/search_page/presentation/widgets/result/result_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({
    Key? key,
    required this.searchState,
    this.path,
  }) : super(key: key);

  final SearchState searchState;
  final String? path;

  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Widget? view;

    if (widget.searchState is InitialSearchState) {
      view = _initialBackgroundLabel();
    } else if (widget.searchState is SearchingSearchState) {
      view = _buildSearchingIndicator();
    } else if (widget.searchState is SearchErrorSearchState) {
      view = _buildErrorLabel();
    } else if (widget.searchState is SearchFinishedSearchState) {
      view = _buildResultsList(
        widget.searchState.props[2] as List<SearchResult>,
      );
    } else if (widget.searchState
        is SearchFinishedButNoResultsFoundSearchState) {
      view = _buildNoResultsLabel();
    } else {
      view = Container();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.searchState is SearchErrorSearchState ||
            widget.searchState is SearchFinishedSearchState)
          _buildSearchResultsHeader(),
        if (widget.searchState is! SearchFinishedSearchState) const Spacer(),
        view,
        if (widget.searchState is! SearchFinishedSearchState) const Spacer(),
        if (widget.path != null) _buildPathLabelBottomBar(),
      ],
    );
  }

  Widget _initialBackgroundLabel() {
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

  Widget _buildPathLabelBottomBar() => Container(
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
            text: 'Searching in\n',
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.path,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );

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
                text: (widget.searchState.props[0] as SearchQueryModel).name,
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: 'No results for \n',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (widget.searchState.props[0] as SearchQueryModel).name,
                  style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
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
                Icons.sentiment_dissatisfied_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorLabel() {
    final size = MediaQuery.of(context).size.shortestSide * 0.6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            widget.searchState.props[0] as String,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.35),
            ),
            padding: EdgeInsets.all(size * 0.15),
            height: size,
            width: size,
            child: const FittedBox(
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsList(List<SearchResult> results) => Expanded(
        child: RawScrollbar(
          thickness: 7.5,
          isAlwaysShown: true,
          thumbColor: Theme.of(context).primaryColorDark,
          radius: const Radius.circular(5),
          controller: _scrollController,
          child: DragSelectGridView(
            scrollController: _scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: results.length,
            itemBuilder: (context, index, selected) => ResultItem(
              item: results[index],
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 10000,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              mainAxisExtent: 90,
            ),
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
}
