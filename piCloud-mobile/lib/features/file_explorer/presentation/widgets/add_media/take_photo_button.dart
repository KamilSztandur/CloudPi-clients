import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TakePhotoButton extends SpeedDialChild {
  final Function onPhotoTaken;

  TakePhotoButton({
    required this.onPhotoTaken,
  }) : super(
          child: Icon(Icons.add_a_photo),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Take and upload photo',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        );
}
