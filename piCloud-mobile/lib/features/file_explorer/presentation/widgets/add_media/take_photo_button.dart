import 'dart:io';

import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class TakePhotoButton extends SpeedDialChild {
  TakePhotoButton({
    required this.onPhotoTaken,
    required this.context,
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
            final photo = await NewMediaWizard(
              context.read<DirectoryManager>(),
            ).takePhoto();

            if (photo != null) {
              onPhotoTaken(photo);
            }
          },
        );

  final void Function(File) onPhotoTaken;
  final BuildContext context;
}
