import 'dart:io';

import 'package:app/features/file_explorer/presentation/widgets/add_media/create_directory_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/pick_file_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/photo_taken_status.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/take_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddMediaButton extends StatefulWidget {
  @override
  _AddMediaButtonState createState() => _AddMediaButtonState();
}

class _AddMediaButtonState extends State<AddMediaButton> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.blueGrey,
      activeForegroundColor: Colors.white,
      buttonSize: 56.0,
      childrenButtonSize: 75,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        CreateDirectoryButton(onSubmitted: _createDirectory, context: context),
        PickFileButton(onFilePicked: _uploadFile),
        TakePhotoButton(onPhotoTaken: _uploadPhoto),
      ],
    );
  }

  void _createDirectory(String directoryName) {
    //TODO

    ScaffoldMessenger.of(context).showSnackBar(_NotificationSnackbar(
      context: context,
      message: "Directory $directoryName created.",
    ));
  }

  void _uploadFile(List<File> files) {
    if (files.length > 0) {
      //TODO

      int n = files.length;
      ScaffoldMessenger.of(context).showSnackBar(_NotificationSnackbar(
        context: context,
        message: "$n file${n > 1 ? 's' : ''} uploaded.",
      ));
    }
  }

  void _uploadPhoto(File file) {
    //TODO

    PhotoTakenPopup(context: context, imageFile: file).show();
  }
}

class _NotificationSnackbar extends SnackBar {
  final String message;
  final BuildContext context;

  _NotificationSnackbar({
    required this.message,
    required this.context,
  }) : super(
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        );
}
