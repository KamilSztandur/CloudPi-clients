import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const ClipOval(
        child: Image(
          fit: BoxFit.scaleDown,
          image: AssetImage('assets/profilepic.jpg'),
        ),
      ),
    );
  }
}
