import 'package:flutter/material.dart';

class UnderConstructionInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Oops!\n',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'This place is not implemented yet.',
                  style: DefaultTextStyle.of(context).style,
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0),
          Image.asset("assets/under_construction.png", height: 300.0),
        ],
      ),
    );
  }
}
