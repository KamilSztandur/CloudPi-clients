import 'dart:io';

import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/create_directory_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/pick_file_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/photo_taken_status.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/take_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:leancode_lint/leancode_lint.dart';
import 'package:provider/provider.dart';

class AddMediaButton extends StatelessWidget {
  const AddMediaButton({
    Key? key,
    required this.currentPath,
    required this.onNewMediaAdded,
  }) : super(key: key);

  final String currentPath;
  final VoidCallback onNewMediaAdded;

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
          onSubmitted: (name) => _createDirectory(context, name),
          context: context,
          path: currentPath,
        ),
        PickFileButton(
          onFilePicked: (files) => _uploadFile(context, files),
          context: context,
        ),
        TakePhotoButton(
          onPhotoTaken: (files) => _uploadPhoto(context, files),
          context: context,
        ),
      ],
    );
  }

  Future<void> _createDirectory(
    BuildContext context,
    String directoryName,
  ) async {
    final result = await context.read<FileExplorerCubit>().createDirectory(
          currentPath,
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
      onNewMediaAdded();
    }
  }

  Future<void> _uploadFile(BuildContext context, List<File> files) async {
    if (files.isNotEmpty) {
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

      try {
        var counter = 0;

        for (final file in files) {
          final result = await context.read<FileExplorerCubit>().uploadFile(
                currentPath,
                file,
              );

          if (result) {
            counter++;
          }
        }
        onNewMediaAdded();
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

  Future<void> _uploadPhoto(BuildContext context, File file) async {
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
      isSuccess =
          await context.read<FileExplorerCubit>().uploadFile(currentPath, file);
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
      onNewMediaAdded();
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
