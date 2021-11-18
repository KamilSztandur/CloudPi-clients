import 'dart:io';

import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PickFileButton extends SpeedDialChild {
  final Function(List<File>) onFilePicked;

  PickFileButton({
    required this.onFilePicked,
  }) : super(
          child: Icon(Icons.note_add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Pick file from storage',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async => onFilePicked(await NewMediaWizard().pickFiles()),
        );
}
