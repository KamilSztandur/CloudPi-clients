import 'package:app/common/widgets/selection_app_bar/option.dart';
import 'package:flutter/material.dart';

class SelectionOptionView extends StatelessWidget {
  const SelectionOptionView({
    Key? key,
    required this.option,
  }) : super(key: key);

  static final icons = {
    Option.download: Icons.download_outlined,
    Option.share: Icons.share,
    Option.rename: Icons.edit_outlined,
    Option.delete: Icons.delete_forever_outlined,
    Option.showDetails: Icons.info_outlined,
    Option.toggleFavorites: Icons.star_outline_outlined,
  };

  static final titles = {
    Option.download: 'Download',
    Option.share: 'Share',
    Option.rename: 'Rename',
    Option.delete: 'Delete',
    Option.showDetails: 'Details',
    Option.toggleFavorites: 'Toggle favorite',
  };

  final Option option;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons[option], color: Theme.of(context).iconTheme.color),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(titles[option]!),
          ),
        ),
      ],
    );
  }
}
