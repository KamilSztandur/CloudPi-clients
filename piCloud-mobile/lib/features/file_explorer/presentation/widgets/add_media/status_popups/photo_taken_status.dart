import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PhotoTakenPopup {
  final BuildContext context;
  final File imageFile;

  PhotoTakenPopup({
    required this.context,
    required this.imageFile,
  });

  void show() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Image saved successfully."),
        contentPadding: EdgeInsets.only(
          top: 15.0,
          right: 15.0,
          left: 15.0,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => AutoRouter.of(context).pop(),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColorDark,
              ),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
        content: Image.file(imageFile),
      ),
    );
  }
}
