import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawerItem extends StatelessWidget {
  final String value;
  final VoidCallback onPressed;
  final IconData? icon;

  const MainDrawerItem(
      {Key? key, required this.value, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          this.icon,
          color: Colors.white,
        ),
        Text(' ' + this.value)
      ]),
      onPressed: this.onPressed,
    );
  }
}
