import 'dart:io';

import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

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
          backgroundColor: Theme.of(context).primaryColor,
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
            await NewMediaWizard(context.read<FileExplorerCubit>()).pickFiles(),
          ),
        );

  final Function(List<File>) onFilePicked;
  final BuildContext context;
}
