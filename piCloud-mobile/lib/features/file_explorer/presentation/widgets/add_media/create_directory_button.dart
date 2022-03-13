import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/create_directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateDirectoryButton extends SpeedDialChild {
  CreateDirectoryButton({
    required this.onSubmitted,
    required this.context,
    required this.path,
  }) : super(
          child: const Icon(
            Icons.create_new_folder,
            size: 35,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          labelWidget: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Create new directory',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10)],
              ),
            ),
          ),
          onTap: () => CreateDirectoryPopup(
            namePicked: onSubmitted,
            context: context,
            path: path,
          ).show(),
        );

  final void Function(String) onSubmitted;
  final BuildContext context;
  final String path;
}
