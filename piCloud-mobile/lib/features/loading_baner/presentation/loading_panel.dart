import 'package:flutter/material.dart';

class LoadingPanel extends StatelessWidget {
  const LoadingPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.75;

    return Center(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColorDark,
                strokeWidth: 5,
              ),
            ),
          ),
          Center(
            child: Text(
              'Please wait...',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
