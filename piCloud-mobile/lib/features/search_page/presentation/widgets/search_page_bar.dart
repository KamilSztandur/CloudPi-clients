import 'package:app/features/app/widgets/app_bar/go_back_leading.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/data/models/search_query_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPageBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchPageBar({
    Key? key,
    required this.queryRequested,
  }) : super(key: key);

  final Function(SearchQueryModel) queryRequested;

  @override
  _SearchPageBarState createState() => _SearchPageBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchPageBarState extends State<SearchPageBar> {
  final TextEditingController _controller = TextEditingController();
  FiltersSettingsModel filters = FiltersSettingsModel.withDefaultSettings();
  String currentQueryValue = '';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      leading: const GoBackLeading(),
      title: _buildQueryTextField(),
      actions: <Widget>[
        if (!_isQueryEmpty()) ...[
          _buildClearQueryButton(),
          _buildSearchButton(),
        ],
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
      decoration: InputDecoration(
        hoverColor: Colors.green,
        hintText: 'Type here...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildSearchButton() => IconButton(
        onPressed: _search,
        icon: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      );

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
    _unfocusKeyboard();
    _clearQuery();

    widget.queryRequested(
      SearchQueryModel(name: currentQueryValue),
    );
  }

  void _unfocusKeyboard() {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _openFiltersPanel() => showGeneralDialog<void>(
        context: context,
        pageBuilder: (_, anim, anim2) => FiltersPanel(
          onFiltersChanged: _updateFilters,
          filtersSettings: filters,
        ),
      );

  void _onQueryChanged(String value) => setState(() {
        currentQueryValue = value;
      });

  void _clearQuery() => setState(_controller.clear);

  bool _isQueryEmpty() => _controller.text.isEmpty;

  void _updateFilters(FiltersSettingsModel filters) {
    this.filters = filters;
  }
}
