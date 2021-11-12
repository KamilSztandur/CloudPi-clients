import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawerItem extends StatelessWidget {
  final String value;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? colorOfIcon;

  const MainDrawerItem(
      {Key? key,
      required this.value,
      required this.onPressed,
      this.icon,
      this.colorOfIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Icon(
          this.icon,
          color: this.colorOfIcon,
        ),
        Text(
          ' ' + this.value,
          style: TextStyle(fontSize: 18),
        )
      ]),
      onPressed: this.onPressed,
    );
  }
}
