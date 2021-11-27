import 'dart:io';

import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TakePhotoButton extends SpeedDialChild {
  TakePhotoButton({
    required this.onPhotoTaken,
  }) : super(
          child: const Icon(
            Icons.add_a_photo,
            size: 35,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          labelWidget: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Take and upload photo',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10)],
              ),
            ),
          ),
          onTap: () async {
            final photo = await NewMediaWizard().takePhoto();

            if (photo != null) {
              onPhotoTaken(photo);
            }
          },
        );

  final void Function(File) onPhotoTaken;
}
