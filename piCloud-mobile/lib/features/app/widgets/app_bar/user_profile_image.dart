import 'package:app/contracts/client_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    required this.size,
    required this.username,
  }) : super(key: key);

  final double size;
  final String username;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FutureBuilder(
        future: _getAvatar(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _getPicture(snapshot.data! as ImageProvider);
          } else {
            return _getPicture(const AssetImage('assets/profilepic.jpg'));
          }
        },
      ),
    );
  }

  Future<ImageProvider> _getAvatar(BuildContext context) async {
    try {
      final api = context.read<Api>();
      final image = await api.userProfileImageGet(username: username);
      image.body!;
      return MemoryImage(image.bodyBytes);
    } catch (exception) {
      return const AssetImage('assets/profilepic.jpg');
    }
  }

  Widget _getPicture(ImageProvider image) {
    return CircleAvatar(
      foregroundImage: image,
    );
  }
}
