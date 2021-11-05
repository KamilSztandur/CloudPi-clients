import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsersPermissionsDrawerItem extends StatelessWidget {
  final String value;

  const UsersPermissionsDrawerItem({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalMargins = 20.0;
    final verticalMargins = 15.0;

    return Container(
        height: 50,
        margin: EdgeInsets.fromLTRB(horizontalMargins, verticalMargins,
            horizontalMargins, verticalMargins),
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ))),
          child: Text(value),
          onPressed: () {
            //TODO
          },
        ));
  }
}
