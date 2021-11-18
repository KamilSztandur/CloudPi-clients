import 'dart:io';

import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TakePhotoButton extends SpeedDialChild {
  final Function(File) onPhotoTaken;

  TakePhotoButton({
    required this.onPhotoTaken,
  }) : super(
          child: Icon(Icons.add_a_photo),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Take and upload photo',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            File? photo = await NewMediaWizard().takePhoto();

            if (photo != null) {
              onPhotoTaken(photo);
            }
          },
        );
}
