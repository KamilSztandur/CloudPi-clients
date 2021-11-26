import 'package:app/features/search_page/bloc/search_bloc.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/presentation/widgets/results_view.dart';
import 'package:app/features/search_page/presentation/widgets/search_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc _bloc;
  SearchQueryModel? _query;
  late FiltersSettingsModel _filters;
  late Widget _resultsView;

  @override
  void initState() {
    _filters = FiltersSettingsModel.withDefaultSettings();
    _bloc = SearchBloc();

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<SearchBloc, SearchState>(
        listener: _searchBlocListener,
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) => Scaffold(
            appBar: SearchPageBar(
              queryRequested: _handleQueryRequest,
              onFiltersChanged: (filters) => _filters = filters,
              currentFilters: _filters,
            ),
            body: ResultsView(searchState: state),
          ),
        ),
      ),
    );
  }

  void _handleQueryRequest(SearchQueryModel query) {
    _bloc.add(QueryRequestedSearchEvent(query: query, filters: _filters));
  }

  void _searchBlocListener(BuildContext context, SearchState state) =>
      setState(() {});
}