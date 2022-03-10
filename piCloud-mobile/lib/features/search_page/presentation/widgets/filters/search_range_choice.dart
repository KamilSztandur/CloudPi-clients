import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRangeChoice extends StatefulWidget {
  const SearchRangeChoice({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final FiltersSettingsModel settings;

  @override
  _SearchRangeChoiceState createState() => _SearchRangeChoiceState();
}

class _SearchRangeChoiceState extends State<SearchRangeChoice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<SearchRange>(
        value: widget.settings.range,
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              widget.settings.range = newValue;
            });
          }
        },
        isExpanded: true,
        underline: Container(),
        icon: const Icon(Icons.expand_more),
        style: const TextStyle(
          fontSize: 15,
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
  }

  String _getRangeChoiceButtonCaption(SearchRange type) {
    switch (type) {
      case SearchRange.everywhere:
        return 'Everywhere';

      case SearchRange.inThisDirectoryAndTheirSubdirectories:
        return 'In this directory and subdirectories';

      default:
        return '???';
    }
  }
}
