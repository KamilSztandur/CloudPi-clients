import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/drawer/main_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.grey[900],
      child: ListView(
        children: [
          Container(
            height: 90.0,
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            child: DrawerHeader(
                child: UserProfileImage(size: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Colors.white60)))),
          ),
          MainDrawerItem(
              value: 'Favorite Content',
              icon: Icons.favorite_outline_outlined,
              colorOfIcon: Colors.red,
              onPressed: () => {
                    //TODO
                  }),
          MainDrawerItem(
              value: 'Shared by You',
              icon: Icons.folder_shared_outlined,
              colorOfIcon: Colors.yellow,
              onPressed: () => {
                    //TODO
                  }),
          MainDrawerItem(
              value: 'Your Settings',
              icon: Icons.settings_outlined,
              colorOfIcon: Colors.grey,
              onPressed: () => {
                    //TODO
                  }),
          MainDrawerItem(
              value: 'Cloud Settings',
              icon: Icons.admin_panel_settings_outlined,
              colorOfIcon: Colors.blue[900],
              onPressed: () => {
                    //TODO
                  }),
          MainDrawerItem(
              value: 'Logout',
              icon: Icons.logout_outlined,
              colorOfIcon: Colors.red[900],
              onPressed: () => {
                    //TODO
                  })
        ],
      ),
    ));
  }
}
