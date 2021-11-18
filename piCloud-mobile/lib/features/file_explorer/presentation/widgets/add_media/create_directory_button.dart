import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/create_directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateDirectoryButton extends SpeedDialChild {
  final Function(String) onSubmitted;
  final BuildContext context;

  CreateDirectoryButton({
    required this.onSubmitted,
    required this.context,
  }) : super(
          child: Icon(Icons.create_new_folder),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Create new directory',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => CreateDirectoryPopup(
            namePicked: onSubmitted,
            context: context,
          ).show(),
        );
}
