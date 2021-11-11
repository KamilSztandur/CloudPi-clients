import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedItemFrame extends StatelessWidget {
  final FileExplorerItem item;
  final double _selectedIconOffset = 5.0;

  SelectedItemFrame({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: _SelectedFileBackground()),
      Center(child: this.item)
      /*  TODO: Fix for mobile - unknown error widget appears.
      Positioned(
        top: _selectedIconOffset,
        right: _selectedIconOffset,
        child: _SelectedFileIcon(
          size: 25.0,
        ),
      ),
      */
    ]);
  }
}

class _SelectedFileBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }
}

class _SelectedFileIcon extends StatelessWidget {
  final double size;

  _SelectedFileIcon({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          )),
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Expanded(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
