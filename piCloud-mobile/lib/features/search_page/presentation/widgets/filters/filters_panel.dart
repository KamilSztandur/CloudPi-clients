import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/date_range_choice.dart';
import 'package:app/features/search_page/presentation/widgets/filters/file_types_choice.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_choice_header.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_dialog_control_buttons.dart';
import 'package:app/features/search_page/presentation/widgets/filters/search_range_choice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiltersPanel extends StatefulWidget {
  const FiltersPanel({
    Key? key,
    required this.onFiltersChanged,
    required this.filtersSettings,
  }) : super(key: key);

  final Function(FiltersSettingsModel) onFiltersChanged;
  final FiltersSettingsModel filtersSettings;

  @override
  _FiltersPanelState createState() => _FiltersPanelState();
}

class _FiltersPanelState extends State<FiltersPanel> {
  late FiltersSettingsModel settings;

  @override
  void initState() {
    settings = FiltersSettingsModel.cloneFrom(widget.filtersSettings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      contentPadding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      actionsAlignment: MainAxisAlignment.center,
      content: _buildWindowContent(),
      actions: _getPossibleActions(),
    );
  }

  Widget _buildTitle() => Text(
        'Edit search filters',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      );

  Widget _buildWindowContent() => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildBody()],
        ),
      );

  List<Widget> _getPossibleActions() => <Widget>[
        ApplyChangesButton(onSubmit: _submit),
        CancelButton(onCancel: _close),
      ];

  Widget _buildBody() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FiltersChoiceHeader(title: 'Search range'),
          _buildInFrame(SearchRangeChoice(settings: settings)),
          const FiltersChoiceHeader(title: 'Allowed types'),
          _buildInFrame(FileTypesChoice(settings: settings)),
          const FiltersChoiceHeader(title: 'Time range'),
          _buildInFrame(DateRangeChoice(settings: settings)),
        ],
      );

  Widget _buildInFrame(Widget child) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColorDark,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: child,
      );

  void _submit() {
    widget.onFiltersChanged(settings);
    _close();
  }

  void _close() => AutoRouter.of(context).pop();
}
