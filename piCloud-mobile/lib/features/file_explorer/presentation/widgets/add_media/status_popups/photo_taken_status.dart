import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PhotoTakenPopup {
  const PhotoTakenPopup({
    required this.context,
    required this.imageFile,
  });

  final BuildContext context;
  final File imageFile;

  void show() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Image saved successfully.',
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(
          top: 15,
          right: 15,
          left: 15,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => AutoRouter.of(context).pop(),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Close',
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
