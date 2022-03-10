import 'package:app/common/widgets/selection_app_bar/option.dart';
import 'package:flutter/material.dart';

class SelectionOptionView extends StatelessWidget {
  const SelectionOptionView({
    Key? key,
    required this.option,
  }) : super(key: key);

  static final icons = {
    Option.download: Icons.download_outlined,
    Option.rename: Icons.edit_outlined,
    Option.delete: Icons.delete_forever_outlined,
    Option.showDetails: Icons.info_outlined,
    Option.addToFavorites: Icons.star_outline_outlined,
  };

  static final titles = {
    Option.download: 'Download',
    Option.rename: 'Rename',
    Option.delete: 'Delete',
    Option.showDetails: 'Details',
    Option.addToFavorites: 'Add to Favourites',
  };

  final Option option;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons[option], color: Colors.black),
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
