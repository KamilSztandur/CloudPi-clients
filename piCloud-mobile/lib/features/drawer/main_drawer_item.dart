import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawerItem extends StatelessWidget {
  final String value;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? colorOfIcon;

  const MainDrawerItem({
    Key? key,
    required this.value,
    required this.onPressed,
    this.icon,
    this.colorOfIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            this.icon,
            color: this.colorOfIcon,
            size: 30,
          ),
          Container(width: 40),
          Text(
            ' ' + this.value,
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
      onPressed: this.onPressed,
    );
  }
}
