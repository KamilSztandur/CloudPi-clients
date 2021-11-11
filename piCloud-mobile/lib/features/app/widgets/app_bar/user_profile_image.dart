import 'package:flutter/cupertino.dart';

class UserProfileImage extends StatelessWidget {
  final double size;

  UserProfileImage({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Image(
          fit: BoxFit.scaleDown,
          image: AssetImage("assets/profilepic.jpg"),
        ),
      ),
    );
  }
}
