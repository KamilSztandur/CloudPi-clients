import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawerItem extends StatelessWidget {
  const MainDrawerItem({
    Key? key,
    required this.value,
    required this.onPressed,
    this.icon,
    this.colorOfIcon,
  }) : super(key: key);

  final String value;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? colorOfIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: colorOfIcon,
            size: 30,
          ),
          Container(width: 40),
          Text(
            ' $value',
            style: const TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
