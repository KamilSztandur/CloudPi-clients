import 'package:flutter/material.dart';

class ProfilePageItem extends StatelessWidget {
  const ProfilePageItem({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(flex: 2),
          _getFlexibleText(label, 22),
          _getFlexibleText(value, 20),
        ],
      ),
    );
  }

  Flexible _getFlexibleText(String text, double fontSize) {
    return Flexible(
      flex: 12,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
