import 'package:flutter/cupertino.dart';

class UserProfileImage extends StatelessWidget {
  final double size;

  UserProfileImage({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.5),
      child: ClipOval(
        child: Image(
          fit: BoxFit.scaleDown,
          image: AssetImage("assets/profilepic.jpg"),
        ),
      ),
    );
  }
}
