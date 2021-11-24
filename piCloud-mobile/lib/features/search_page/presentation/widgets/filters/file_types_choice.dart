import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:flutter/material.dart';

class FileTypesChoice extends StatefulWidget {
  const FileTypesChoice({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final FiltersSettingsModel settings;

  @override
  _FileTypesChoiceState createState() => _FileTypesChoiceState();
}

class _FileTypesChoiceState extends State<FileTypesChoice> {
  final checkboxesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => RawScrollbar(
        controller: checkboxesScrollController,
        isAlwaysShown: true,
        thumbColor: Theme.of(context).primaryColorDark,
        radius: const Radius.circular(10),
        child: ListView.builder(
          controller: checkboxesScrollController,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          itemCount: FileExplorerItemType.values.length,
          itemBuilder: (context, index) {
            final type = FileExplorerItemType.values[index];

            return CheckboxListTile(
              value: widget.settings.allowedFileTypes![type],
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              dense: true,
              checkColor: Colors.white,
              activeColor: Colors.black,
              title: Text(
                _getFileTypeCheckboxTitle(type),
                style: const TextStyle(fontSize: 15),
              ),
              onChanged: (newValue) => setState(() {
                widget.settings.allowedFileTypes![type] = newValue ?? false;
              }),
            );
          },
        ),
      );

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

  bool _shouldDisplayUpperArrow() {
    final isAtEdge = checkboxesScrollController.position.atEdge;
    final isAtBeginning = checkboxesScrollController.offset == 0;

    if (isAtEdge && isAtBeginning) {
      return false;
    } else {
      return true;
    }
  }

  bool _shouldDisplayBottomArrow() {
    final isAtEdge = checkboxesScrollController.position.atEdge;
    final isAtBeginning = checkboxesScrollController.offset == 0;

    if (isAtEdge && isAtBeginning) {
      return true;
    } else {
      return false;
    }
  }
}
