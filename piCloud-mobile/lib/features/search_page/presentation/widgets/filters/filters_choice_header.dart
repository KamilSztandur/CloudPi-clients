import 'package:flutter/material.dart';

class FiltersChoiceHeader extends StatelessWidget {
  const FiltersChoiceHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColorDark,
          fontSize: 15,
        ),
      ),
    );
  }
}
