import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final double height;

  AppBarTitle({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            // return to main page
          },
          child: Container(
            padding: EdgeInsets.all(7.5),
            height: this.height,
            child: Image(
              fit: BoxFit.scaleDown,
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}
