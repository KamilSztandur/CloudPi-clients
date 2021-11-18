import 'dart:io';

import 'package:app/features/file_explorer/presentation/widgets/add_media/create_directory_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/pick_file_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/take_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddMediaButton extends StatelessWidget {
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
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
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
  }

  void _uploadFile(List<File> files) {
    //TODO
  }

  void _uploadPhoto() {
    //TODO
  }
}
