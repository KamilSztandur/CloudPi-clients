import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // return to main page
          },
          child: Container(
            padding: const EdgeInsets.all(7.5),
            height: height,
            child: const Image(
              fit: BoxFit.scaleDown,
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}
