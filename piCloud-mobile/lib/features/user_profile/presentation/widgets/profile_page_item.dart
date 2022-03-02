import 'package:flutter/material.dart';

class ProfilePageItem extends StatelessWidget {
  const ProfilePageItem({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(flex: 4),
          _getFlexibleText(label, 22, 14),
          _getFlexibleText(value, 20, 16),
        ],
      ),
    );
  }

  Flexible _getFlexibleText(String text, double fontSize, int flex) {
    return Flexible(
      flex: flex,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
