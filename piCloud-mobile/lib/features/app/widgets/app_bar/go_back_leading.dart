import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class GoBackLeading extends StatelessWidget {
  const GoBackLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,
      ),
      onPressed: () => AutoRouter.of(context).pop(),
    );
  }
}
