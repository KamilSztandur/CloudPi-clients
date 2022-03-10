import 'package:app/features/search_page/data/models/search_result.dart';
import 'package:flutter/material.dart';

class MoreActionsMenu extends StatelessWidget {
  const MoreActionsMenu({
    Key? key,
    required this.item,
    required this.onOpenLocalizationClicked,
    required this.onDetailsClicked,
  }) : super(key: key);

  final SearchResult item;
  final VoidCallback onOpenLocalizationClicked, onDetailsClicked;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _onMoreMenuOptionSelected,
      itemBuilder: (_) => <PopupMenuEntry<String>>[
        _buildPopupListItem('Open localization', Icons.folder_open),
        _buildPopupListItem('Details', Icons.info_outline),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupListItem(String title, IconData icon) =>
      PopupMenuItem<String>(
        value: title,
        child: Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      );

  void _onMoreMenuOptionSelected(String value) {
    switch (value) {
      case 'Open localization':
        onOpenLocalizationClicked();
        break;

      case 'Details':
        onDetailsClicked();
        break;

      default:
      //Ignore
    }
  }
}
