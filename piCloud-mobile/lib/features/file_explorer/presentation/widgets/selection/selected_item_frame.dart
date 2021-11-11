import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedItemFrame extends StatelessWidget {
  final FileExplorerItem item;

  SelectedItemFrame({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: this.item,
    );
  }
}
