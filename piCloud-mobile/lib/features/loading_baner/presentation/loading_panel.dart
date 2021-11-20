import 'package:flutter/material.dart';

class LoadingPanel extends StatelessWidget {
  const LoadingPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.8;

    return Center(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/loading.gif',
                  height: 125,
                  width: 125,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
