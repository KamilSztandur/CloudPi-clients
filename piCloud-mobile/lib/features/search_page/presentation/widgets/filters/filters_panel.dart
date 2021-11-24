import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/date_range_choice.dart';
import 'package:app/features/search_page/presentation/widgets/filters/file_types_choice.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_choice_header.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_dialog_control_buttons.dart';
import 'package:app/features/search_page/presentation/widgets/filters/misc_settings_choice.dart';
import 'package:app/features/search_page/presentation/widgets/filters/search_range_choice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 550,
        ),
        child: _buildWindowContent(),
      ),
      actions: _getPossibleActions(),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      buttonPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 15),
      insetPadding: const EdgeInsets.all(10),
    );
  }

  Widget _buildTitle() => Text(
        'Edit search filters',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      );

  Widget _buildWindowContent() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        child: _buildBody(),
      );

  List<Widget> _getPossibleActions() => <Widget>[
        ApplyChangesButton(onSubmit: _submit),
        CancelButton(onCancel: _close),
      ];

  Widget _buildBody() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FiltersChoiceHeader(title: 'Search range'),
          _buildInFrame(
            SearchRangeChoice(settings: settings),
            'SearchRange',
            false,
          ),
          const FiltersChoiceHeader(title: 'Miscellaneous'),
          _buildInFrame(
            SizedBox(height: 75, child: MiscSettingsChoice(settings: settings)),
            'Miscellaneous',
            false,
          ),
          const FiltersChoiceHeader(title: 'Time range'),
          _buildInFrame(
            DateRangeChoice(settings: settings),
            'Time range',
            false,
          ),
          const FiltersChoiceHeader(title: 'Allowed types'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 180),
            child: _buildInFrame(
              FileTypesChoice(settings: settings),
              'Allowed types',
              true,
            ),
          ),
        ],
      );

  Widget _buildInFrame(Widget child, String title, bool expandable) {
    final frame = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: child,
    );

    if (expandable) {
      return Expanded(child: frame);
    } else {
      return frame;
    }
  }

  void _submit() {
    widget.onFiltersChanged(settings);
    _close();
  }

  void _close() => AutoRouter.of(context).pop();
}
