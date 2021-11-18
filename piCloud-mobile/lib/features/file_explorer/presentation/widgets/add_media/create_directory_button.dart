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
          child: Icon(
            Icons.create_new_folder,
            size: 35.0,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          labelWidget: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Create new directory',
              textAlign: TextAlign.right,
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
          onTap: () => CreateDirectoryPopup(
            namePicked: onSubmitted,
            context: context,
          ).show(),
        );
}
