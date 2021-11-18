import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateDirectoryButton extends SpeedDialChild {
  final Function onSubmitted;

  CreateDirectoryButton({
    required this.onSubmitted,
  }) : super(
          child: Icon(Icons.create_new_folder),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Create new directory',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        );
}
