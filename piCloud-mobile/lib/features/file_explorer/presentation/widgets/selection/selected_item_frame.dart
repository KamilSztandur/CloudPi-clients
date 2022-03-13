import 'package:flutter/material.dart';

class SelectedItemFrame extends StatelessWidget {
  const SelectedItemFrame({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  // ignore: unused_field
  final double _selectedIconOffset = 5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: _SelectedFileBackground()),
        Center(child: child),
        Positioned(
          top: _selectedIconOffset,
          right: _selectedIconOffset,
          child: const _SelectedFileIcon(
            size: 25,
          ),
        ),
      ],
    );
  }
}

class _SelectedFileBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}

class _SelectedFileIcon extends StatelessWidget {
  const _SelectedFileIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColorDark,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
