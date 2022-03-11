import 'dart:io';

import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/create_directory_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/pick_file_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/photo_taken_status.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/take_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:leancode_lint/leancode_lint.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class AddMediaButton extends StatefulWidget {
  const AddMediaButton({
    Key? key,
    required this.currentPath,
    required this.onNewMediaAdded,
  }) : super(key: key);

  final String currentPath;
  final VoidCallback onNewMediaAdded;

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
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.grey,
      activeForegroundColor: Colors.white,
      childrenButtonSize: 75,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      elevation: 8,
      shape: const CircleBorder(),
      children: [
        CreateDirectoryButton(
          onSubmitted: _createDirectory,
          context: context,
          path: widget.currentPath,
        ),
        PickFileButton(onFilePicked: _uploadFile, context: context),
        TakePhotoButton(onPhotoTaken: _uploadPhoto, context: context),
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

    if (result) {
      widget.onNewMediaAdded();
    }
  }

  Future<void> _uploadFile(List<File> files) async {
    if (files.isNotEmpty) {
      // ignore: unawaited_futures
      showDialog<void>(
        context: context,
        builder: (context) => const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),
        ),
      );

      try {
        var counter = 0;

        for (final file in files) {
          final result = await directoryManager.uploadFile(
            widget.currentPath,
            file,
          );

          if (result) {
            counter++;
          }
        }
        widget.onNewMediaAdded();
        ScaffoldMessenger.of(context).showSnackBar(
          _NotificationSnackbar(
            context: context,
            message: "$counter file${counter > 1 ? 's' : ''} uploaded.",
          ),
        );
      } catch (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          _NotificationSnackbar(
            context: context,
            message: 'Upload failed.',
          ),
        );
      } finally {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _uploadPhoto(File file) async {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    var isSuccess = false;
    try {
      isSuccess = await directoryManager.uploadPhoto(widget.currentPath, file);
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        _NotificationSnackbar(
          context: context,
          message: 'Upload failed.',
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }

    if (isSuccess) {
      widget.onNewMediaAdded();
      PhotoTakenPopup(context: context, imageFile: file).show();
    }
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
