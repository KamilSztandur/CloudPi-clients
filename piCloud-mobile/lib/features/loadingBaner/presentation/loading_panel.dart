import 'package:flutter/material.dart';

class LoadingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide * 0.8;

    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3.0,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/loading.gif",
                  height: 125.0,
                  width: 125.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
