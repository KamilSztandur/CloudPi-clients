import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/drawer/users_permission_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsersPermissionsDrawer extends StatelessWidget {
  const UsersPermissionsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              height: 90.0,
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        child: Icon(Icons.list_outlined, size: 30.0),
                        onPressed: () {
                          //TODO
                        }),
                    Text(
                      'Users Permissions',
                      style: TextStyle(fontSize: 16),
                    ),
                    UserProfileImage(size: 15.0)
                  ],
                ),
              )),
          UsersPermissionsDrawerItem(value: 'Hehe Hehe'),
          UsersPermissionsDrawerItem(value: 'Haha Hehe'),
          UsersPermissionsDrawerItem(value: 'Hoho Hehe'),
          UsersPermissionsDrawerItem(value: 'H@h@ Hehe'),
          UsersPermissionsDrawerItem(value: 'Hihi Haha'),
          UsersPermissionsDrawerItem(value: 'Haha Hehe'),
          UsersPermissionsDrawerItem(value: 'Hyhy Hehe')
        ],
      ),
    );
  }
}
