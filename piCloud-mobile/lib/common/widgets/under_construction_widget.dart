import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnderConstructionInfo extends StatelessWidget {
  const UnderConstructionInfo({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pageName,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 50),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Oops!\n',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'This place is not implemented yet.',
                  style: DefaultTextStyle.of(context).style,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Image.asset('assets/under_construction.png', height: 300),
        ],
      ),
    );
  }
}
