import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_dialog_control_buttons.dart';
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
  final checkboxesScrollController = ScrollController();
  late FiltersSettingsModel settings;
  final DateTime minPossibleDate = DateTime(2000);
  final DateTime maxPossibleDate = DateTime.now();

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
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildBody()],
        ),
      ),
      actions: [
        ApplyChangesButton(onSubmit: _submit),
        CancelButton(onCancel: _close),
      ],
    );
  }

  Widget _buildTitle() => Text(
        'Edit search filters',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      );

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Search range'),
        _buildInFrame(_buildSearchRangeChoice()),
        _buildHeader('Allowed types'),
        _buildInFrame(
          _buildFileTypesSelection(),
        ),
        _buildHeader('Time range'),
        _buildInFrame(
          _buildTimeRangeChoice(),
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: _clearDateRange,
            child: const Text(
              'Clear date range',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInFrame(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: child,
    );
  }

  Widget _buildHeader(String text) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 15,
          ),
        ),
      );

  Widget _buildSearchRangeChoice() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<SearchRange>(
          value: settings.range,
          onChanged: (newValue) {
            setState(() {
              settings.range = newValue ?? settings.range;
            });
          },
          isExpanded: true,
          underline: Container(),
          icon: const Icon(Icons.expand_more),
          iconEnabledColor: Colors.black,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
          items: SearchRange.values.map<DropdownMenuItem<SearchRange>>(
            (value) {
              return DropdownMenuItem<SearchRange>(
                value: value,
                child: Text(_getRangeChoiceButtonCaption(value)),
              );
            },
          ).toList(),
        ),
      );

  Widget _buildTimeRangeChoice() => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _pickMinDate,
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 5),
                      Text(
                        _getMinDayText(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_right_alt_outlined),
                GestureDetector(
                  onTap: _pickMaxDate,
                  child: Row(
                    children: [
                      Text(
                        _getMaxDayText(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.date_range),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildFileTypesSelection() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 170,
      ),
      child: SingleChildScrollView(
        controller: checkboxesScrollController,
        child: Scrollbar(
          controller: checkboxesScrollController,
          isAlwaysShown: true,
          child: Column(
            children: <Widget>[
              ..._getCheckboxes(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCheckboxes() {
    final checkboxes = <Widget>[];

    for (final type in FileExplorerItemType.values) {
      checkboxes.add(
        CheckboxListTile(
          value: settings.allowedFileTypes![type],
          title: Text(
            _getFileTypeCheckboxTitle(type),
            style: const TextStyle(fontSize: 15),
          ),
          onChanged: (newValue) {
            setState(() {
              settings.allowedFileTypes![type] = newValue ?? false;
            });
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          dense: true,
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
      );
    }

    return checkboxes;
  }

  String _getFileTypeCheckboxTitle(FileExplorerItemType type) {
    switch (type) {
      case FileExplorerItemType.directory:
        return 'Directories';

      case FileExplorerItemType.image:
        return 'Images';

      case FileExplorerItemType.video:
        return 'Videos';

      case FileExplorerItemType.music:
        return 'Sound files';

      case FileExplorerItemType.pdf:
        return 'PDF files';

      case FileExplorerItemType.text:
        return 'Text files';

      case FileExplorerItemType.file:
        return 'Other files';

      default:
        return '???';
    }
  }

  String _getRangeChoiceButtonCaption(SearchRange type) {
    switch (type) {
      case SearchRange.everywhere:
        return 'Everywhere';

      case SearchRange.inThisDirectoryAndTheirSubdirectories:
        return 'In this directory and subdirectories';

      case SearchRange.onlyInThisDirectory:
        return 'Only in this directory';

      default:
        return '???';
    }
  }

  String _getMaxDayText() {
    final selectedDate = settings.max!;
    final now = DateTime.now();

    if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      return 'Now';
    } else {
      return _getFormattedDateText(selectedDate);
    }
  }

  String _getMinDayText() {
    final selectedDate = settings.min!;
    final defaultDate = FiltersSettingsModel.withDefaultSettings().min!;

    if (selectedDate.year == defaultDate.year &&
        selectedDate.month == defaultDate.month &&
        selectedDate.day == defaultDate.day) {
      return 'Always';
    } else {
      return _getFormattedDateText(selectedDate);
    }
  }

  String _getFormattedDateText(DateTime date) =>
      DateFormat('d.M.y').format(date);

  Future<void> _pickMinDate() async {
    final minDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: settings.min!,
        firstDate: minPossibleDate,
        lastDate: settings.max!,
      ),
    );

    if (minDate != null) {
      setState(() {
        settings.min = minDate;
      });
    }
  }

  Future<void> _pickMaxDate() async {
    final maxDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: settings.max!,
        firstDate: settings.min!,
        lastDate: maxPossibleDate,
      ),
    );

    if (maxDate != null) {
      setState(() {
        settings.max = maxDate;
      });
    }
  }

  void _clearDateRange() => setState(() {
        settings
          ..min = minPossibleDate
          ..max = maxPossibleDate;
      });

  void _submit() {
    widget.onFiltersChanged(settings);
    _close();
  }

  void _close() => AutoRouter.of(context).pop();
}
