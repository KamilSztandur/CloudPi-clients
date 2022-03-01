import 'dart:io';

import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class PickFileButton extends SpeedDialChild {
  PickFileButton({
    required this.onFilePicked,
    required this.context,
  }) : super(
          child: const Icon(
            Icons.note_add,
            size: 35,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          labelWidget: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Pick file from storage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10)],
              ),
            ),
          ),
          onTap: () async => onFilePicked(
            await NewMediaWizard(context.read<DirectoryManager>()).pickFiles(),
          ),
        );

  final Function(List<File>) onFilePicked;
  final BuildContext context;
}
