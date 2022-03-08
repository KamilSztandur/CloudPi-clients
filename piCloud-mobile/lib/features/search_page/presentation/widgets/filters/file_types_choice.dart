import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
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
  final _gridViewController = DragSelectGridViewController();

  @override
  Widget build(BuildContext context) => RawScrollbar(
        controller: checkboxesScrollController,
        isAlwaysShown: true,
        thumbColor: Theme.of(context).primaryColorDark,
        radius: const Radius.circular(10),
        child: DragSelectGridView(
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
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            mainAxisExtent: 40,
          ),
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

      case FileExplorerItemType.compressed:
        return 'Archives';

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
