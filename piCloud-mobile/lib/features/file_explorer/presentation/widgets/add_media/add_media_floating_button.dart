import 'dart:io';

import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/create_directory_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/pick_file_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/photo_taken_status.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/take_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/src/provider.dart';

class AddMediaButton extends StatefulWidget {
  const AddMediaButton({
    Key? key,
    required this.currentPath,
  }) : super(key: key);

  final String currentPath;

  @override
  _AddMediaButtonState createState() => _AddMediaButtonState();
}

class _AddMediaButtonState extends State<AddMediaButton> {
  late DirectoryManager directoryManager;

  @override
  void initState() {
    directoryManager = context.read<DirectoryManager>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.blueGrey,
      activeForegroundColor: Colors.white,
      childrenButtonSize: 75,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      elevation: 8,
      shape: const CircleBorder(),
      children: [
        CreateDirectoryButton(onSubmitted: _createDirectory, context: context),
        PickFileButton(onFilePicked: _uploadFile),
        TakePhotoButton(onPhotoTaken: _uploadPhoto),
      ],
    );
  }

  Future<void> _createDirectory(String directoryName) async {
    final result = await directoryManager.createNewDirectory(
      widget.currentPath,
      directoryName,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      _NotificationSnackbar(
        context: context,
        message: result == true
            ? 'Directory $directoryName created.'
            : 'Failed to create new directory $directoryName.',
      ),
    );
  }

  void _uploadFile(List<File> files) {
    if (files.isNotEmpty) {
      //TODO

      final n = files.length;
      ScaffoldMessenger.of(context).showSnackBar(
        _NotificationSnackbar(
          context: context,
          message: "$n file${n > 1 ? 's' : ''} uploaded.",
        ),
      );
    }
  }

  void _uploadPhoto(File file) {
    //TODO

    PhotoTakenPopup(context: context, imageFile: file).show();
  }
}

class _NotificationSnackbar extends SnackBar {
  _NotificationSnackbar({
    required this.message,
    required this.context,
  }) : super(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        );

  final String message;
  final BuildContext context;
}
