import 'package:flutter/material.dart';

class ResultItemTitleLabel extends StatelessWidget {
  const ResultItemTitleLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 17.5),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
