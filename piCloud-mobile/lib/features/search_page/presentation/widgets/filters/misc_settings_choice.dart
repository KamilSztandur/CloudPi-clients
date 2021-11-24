import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiscSettingsChoice extends StatefulWidget {
  const MiscSettingsChoice({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final FiltersSettingsModel settings;

  @override
  _MiscSettingsChoiceState createState() => _MiscSettingsChoiceState();
}

class _MiscSettingsChoiceState extends State<MiscSettingsChoice> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _switchButtons = <Widget>[
      _buildMatchLetterCaseSwitch(),
      _buildMatchWholeWordsSwitch(),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Scrollbar(
        controller: _scrollController,
        child: DragSelectGridView(
          itemCount: _switchButtons.length,
          itemBuilder: (context, index, selected) => _switchButtons[index],
          scrollController: _scrollController,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 1260,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            mainAxisExtent: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchLetterCaseSwitch() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Match letter cases'),
          Switch(
            value: widget.settings.matchLetterCases ?? false,
            onChanged: (value) => setState(() {
              widget.settings.matchLetterCases = value;
            }),
          ),
        ],
      );

  Widget _buildMatchWholeWordsSwitch() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Match whole words'),
          Switch(
            value: widget.settings.matchWholeWords ?? false,
            onChanged: (value) => setState(() {
              widget.settings.matchWholeWords = value;
            }),
          ),
        ],
      );
}

/*
Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Match whole words'),
              Switch(
                value: value2,
                onChanged: (value) => setState(() {
                  value2 = value;
                }),
              ),
            ],
          ),
*/

/*
DragSelectGridView(
          scrollController: checkboxesScrollController,
          gridController: _gridViewController,
          padding: EdgeInsets.zero,
          itemCount: FileExplorerItemType.values.length,
          itemBuilder: (context, index, selected) {
            final type = FileExplorerItemType.values[index];

            final title = Text(
              _getFileTypeCheckboxTitle(type),
              style: const TextStyle(fontSize: 15),
            );

            final checkBox = Checkbox(
              value: widget.settings.allowedFileTypes![type] ?? false,
              onChanged: (newValue) => setState(() {
                widget.settings.allowedFileTypes![type] = newValue ?? false;
              }),
              activeColor: Colors.black,
              hoverColor: Colors.white,
            );

            return Row(
              children: [checkBox, title],
            );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 160,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            mainAxisExtent: 40,
          ),
        ),
*/
