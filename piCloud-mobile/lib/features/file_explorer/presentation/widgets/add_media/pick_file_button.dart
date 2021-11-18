import 'dart:io';

import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PickFileButton extends SpeedDialChild {
  final Function(List<File>) onFilePicked;

  PickFileButton({
    required this.onFilePicked,
  }) : super(
          child: Icon(
            Icons.note_add,
            size: 35.0,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          labelWidget: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Pick file from storage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
          onTap: () async => onFilePicked(await NewMediaWizard().pickFiles()),
        );
}
