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
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.9, 1.0],
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: SingleChildScrollView(
              controller: checkboxesScrollController,
              child: Scrollbar(
                controller: checkboxesScrollController,
                isAlwaysShown: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ..._getCheckboxes(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getCheckboxes() {
    final checkboxes = <Widget>[];

    for (final type in FileExplorerItemType.values) {
      checkboxes.add(
        CheckboxListTile(
          value: widget.settings.allowedFileTypes![type],
          title: Text(
            _getFileTypeCheckboxTitle(type),
            style: const TextStyle(fontSize: 15),
          ),
          onChanged: (newValue) {
            setState(() {
              widget.settings.allowedFileTypes![type] = newValue ?? false;
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
