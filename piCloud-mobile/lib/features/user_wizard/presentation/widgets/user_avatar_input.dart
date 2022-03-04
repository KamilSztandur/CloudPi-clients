import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatarInput extends StatefulWidget {
  const UserAvatarInput({
    Key? key,
    required this.imagePicked,
  }) : super(key: key);

  final Function(File) imagePicked;

  @override
  _UserAvatarInputState createState() => _UserAvatarInputState();
}

class _UserAvatarInputState extends State<UserAvatarInput> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? fgImage;

    try {
      fgImage = FileImage(image!);
    } catch (exception) {
      fgImage = null;
    }

    return FittedBox(
      fit: BoxFit.fitHeight,
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          padding: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            foregroundImage: fgImage,
            child: const Icon(Icons.add_photo_alternate_outlined),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final parsedImage = File(image.path);

      setState(() {
        this.image = parsedImage;
      });

      widget.imagePicked(this.image!);
    }
  }
}
