import 'package:app/common/core/config.dart';
import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/drawer/main_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            _getDrawerHeader(),
            _getDrawerOptions(context),
            Spacer(flex: 3),
            _getVersionInfoLabel(),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerHeader() {
    return Container(
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.white60),
        ),
      ),
      child: Center(
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 70,
                width: 74,
                child: UserProfileImage(size: 60),
              ),
              Text(
                'Adam44', //Mock or sth, should get username from user's data
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDrawerOptions(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MainDrawerItem(
            value: 'User Profile',
            icon: Icons.account_box_outlined,
            onPressed: _onUserProfileTapped,
          ),
          MainDrawerItem(
            value: 'Settings',
            icon: Icons.settings_outlined,
            onPressed: _onSettingsTapped,
          ),
          MainDrawerItem(
            value: 'Cloud Settings',
            icon: Icons.admin_panel_settings_outlined,
            onPressed: _onCloudSettingsTapped,
          ),
          MainDrawerItem(
            value: 'About',
            icon: Icons.info_outline,
            onPressed: () => _onAboutTapped(context),
          ),
          MainDrawerItem(
            value: 'Logout',
            icon: Icons.logout_outlined,
            onPressed: _onLogoutTapped,
          ),
        ],
      ),
    );
  }

  Widget _getVersionInfoLabel() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'PiCloud Mobile',
            style: TextStyle(color: Colors.white60, fontSize: 16),
          ),
          Text(
            Config.version,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          )
        ],
      ),
    );
  }

  void _onUserProfileTapped() {
    //TODO
  }

  void _onSettingsTapped() {
    //TODO
  }

  void _onCloudSettingsTapped() {
    //TODO
  }

  void _onAboutTapped(BuildContext context) => showAboutDialog(
        context: context,
        applicationName: Config.applicationName,
        applicationLegalese: Config.applicationLegalese,
        applicationVersion: Config.version,
      );

  void _onLogoutTapped() {
    //TODO
  }
}
