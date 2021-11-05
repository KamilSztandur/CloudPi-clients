import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//work in progress!
class UserPermissionsDrawer extends StatelessWidget {
  const UserPermissionsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              height: 80.0,
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: DrawerHeader(
                decoration: new BoxDecoration(color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //TODO
                        },
                        child: Icon(Icons.list_outlined, size: 30.0)),
                    Text('Users Permissions'),
                    UserProfileImage(size: 10.0)
                  ],
                ),
              )),
          ListItemTMP(),
          ListItemTMP(),
          ListItemTMP(),
          ListItemTMP()
        ],
      ),
    );
  }
}

class ListItemTMP extends StatelessWidget {
  const ListItemTMP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30.0,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              'Some item',
              style: TextStyle(backgroundColor: Colors.grey),
            )));
  }
}
