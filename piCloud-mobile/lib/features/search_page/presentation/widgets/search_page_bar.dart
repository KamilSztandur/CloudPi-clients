import 'package:app/features/app/widgets/app_bar/go_back_leading.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPageBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchPageBar({
    Key? key,
    required this.currentFilters,
    required this.queryRequested,
    required this.onFiltersChanged,
  }) : super(key: key);

  final Function(SearchQueryModel) queryRequested;
  final Function(FiltersSettingsModel) onFiltersChanged;
  final FiltersSettingsModel currentFilters;

  @override
  _SearchPageBarState createState() => _SearchPageBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchPageBarState extends State<SearchPageBar> {
  final TextEditingController _controller = TextEditingController();
  late FiltersSettingsModel filters;

  @override
  void initState() {
    filters = FiltersSettingsModel.cloneFrom(widget.currentFilters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      leading: const GoBackLeading(),
      title: _buildQueryTextField(),
      actions: <Widget>[
        if (!_isQueryEmpty()) _buildClearQueryButton(),
        _buildEditFiltersButton(),
      ],
    );
  }

  Widget _buildQueryTextField() {
    const fontSize = 20.0;

    return TextField(
      controller: _controller,
      onChanged: _onQueryChanged,
      onSubmitted: (value) => _search(value: value),
      style: const TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        filled: true,
        hintText: 'Type here...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
        ),
        fillColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
        contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildClearQueryButton() => IconButton(
        onPressed: _clearQuery,
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
      );

  Widget _buildEditFiltersButton() => IconButton(
        onPressed: _openFiltersPanel,
        icon: const Icon(
          Icons.tune,
          color: Colors.white,
        ),
      );

  void _search({String? value}) {
    _clearQuery();

    widget.queryRequested(SearchQueryModel(name: value));
  }

  void _unfocusKeyboard() {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _openFiltersPanel() => showDialog<void>(
        context: context,
        builder: (_) => FiltersPanel(
          onFiltersChanged: _updateFilters,
          filtersSettings: filters,
        ),
      );

  void _onQueryChanged(String value) => setState(() {});

  void _clearQuery() {
    _unfocusKeyboard();
    setState(_controller.clear);
  }

  bool _isQueryEmpty() => _controller.text.isEmpty;

  void _updateFilters(FiltersSettingsModel filters) {
    this.filters = filters;

    widget.onFiltersChanged(filters);
  }
}
