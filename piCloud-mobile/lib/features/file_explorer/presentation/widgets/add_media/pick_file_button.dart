import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PickFileButton extends SpeedDialChild {
  final Function onFilePicked;

  PickFileButton({
    required this.onFilePicked,
  }) : super(
          child: Icon(Icons.note_add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Add file from storage',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        );
}
