import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FileExplorerErrorWidget extends StatelessWidget {
  String? errorMessage;

  FileExplorerErrorWidget({
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_outlined,
            size: 150.0,
            color: Colors.black,
          ),
          SizedBox(height: 7.5),
          Text(
            "Oops! Something went wrong.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.0),
          Text(
            "$errorMessage",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
