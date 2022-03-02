import 'package:app/common/core/config.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoSize = MediaQuery.of(context).size.shortestSide * 0.35;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/Logo.png',
          height: logoSize,
          width: logoSize,
        ),
        const Text(
          Config.applicationName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
