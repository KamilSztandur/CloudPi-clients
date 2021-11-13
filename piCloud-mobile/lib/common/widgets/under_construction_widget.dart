import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnderConstructionInfo extends StatelessWidget {
  final String pageName;

  UnderConstructionInfo({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.pageName,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
          SizedBox(height: 50.0),
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
