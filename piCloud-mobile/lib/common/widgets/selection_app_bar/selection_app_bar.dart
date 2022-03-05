import 'package:app/common/widgets/selection_app_bar/option.dart';
import 'package:app/common/widgets/selection_app_bar/selection_option_view.dart';
import 'package:flutter/material.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key? key,
    required this.selectionCount,
    this.onDownload,
    this.onRename,
    this.onDelete,
    this.onShowDetails,
    this.onAddToFavorites,
  }) : super(key: key);

  final int selectionCount;
  final VoidCallback? onDownload;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;
  final VoidCallback? onShowDetails;
  final VoidCallback? onAddToFavorites;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: const CloseButton(),
      title: Text(
        _getTitle(),
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        PopupMenuButton<Option>(
          onSelected: _onOptionSelected,
          itemBuilder: (context) => _getMenuItems(),
        )
      ],
    );
  }

  String _getTitle() =>
      'Selected $selectionCount item${selectionCount > 1 ? 's.' : '.'}';

  List<PopupMenuItem<Option>> _getMenuItems() => [
        if (onDownload != null) Option.download,
        if (onRename != null) Option.rename,
        if (onDelete != null) Option.delete,
        if (onShowDetails != null) Option.showDetails,
        if (onAddToFavorites != null) Option.addToFavorites,
      ]
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: SelectionOptionView(option: option),
            ),
          )
          .toList();

  Future<void> _onOptionSelected(Option option) async {
    switch (option) {
      case Option.download:
        onDownload?.call();
        break;
      case Option.rename:
        onRename?.call();
        break;
      case Option.delete:
        onDelete?.call();
        break;
      case Option.showDetails:
        onShowDetails?.call();
        break;
      case Option.addToFavorites:
        onAddToFavorites?.call();
        break;
    }
  }
}
