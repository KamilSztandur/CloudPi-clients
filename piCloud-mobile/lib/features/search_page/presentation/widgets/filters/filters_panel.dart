import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:app/features/search_page/presentation/widgets/filters/filters_dialog_control_buttons.dart';
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
  final checkboxesScrollController = ScrollController();
  late FiltersSettingsModel settings;

  @override
  void initState() {
    settings = widget.filtersSettings;
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
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: _buildBody(),
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
        Flexible(
          child: _buildInFrame(_buildFileTypesSelection()),
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

  Widget _buildFileTypesSelection() {
    return SingleChildScrollView(
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

  void _submit() {
    widget.onFiltersChanged(settings);
    _close();
  }

  void _close() => AutoRouter.of(context).pop();
}
