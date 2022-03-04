import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/drawer/main_drawer_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            FutureBuilder(
              future: _getDrawerHeader(context.read<AuthManager>()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data! as Widget;
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            _getDrawerOptions(context),
            const Spacer(flex: 3),
            _getVersionInfoLabel(),
          ],
        ),
      ),
    );
  }

  Future<Widget> _getDrawerHeader(AuthManager authManager) async {
    final username = await authManager.getUsernameOfLoggedUser();

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.white60),
        ),
      ),
      child: Center(
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 70,
                width: 74,
                child: UserProfileImage(
                  size: 60,
                  username: username!,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDrawerOptions(BuildContext context) {
    return Column(
      children: [
        MainDrawerItem(
          value: 'User Profile',
          icon: Icons.account_box_outlined,
          onPressed: () => _onUserProfileTapped(context),
        ),
        MainDrawerItem(
          value: 'Settings',
          icon: Icons.settings_outlined,
          onPressed: () => _onSettingsTapped(context),
        ),
        MainDrawerItem(
          value: 'Cloud Settings',
          icon: Icons.admin_panel_settings_outlined,
          onPressed: () => _onCloudSettingsTapped(context),
        ),
        MainDrawerItem(
          value: 'About',
          icon: Icons.info_outline,
          onPressed: () => _onAboutTapped(context),
        ),
        MainDrawerItem(
          value: 'Logout',
          icon: Icons.logout_outlined,
          onPressed: () => _onLogoutTapped(context),
        ),
      ],
    );
  }

  Widget _getVersionInfoLabel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          'PiCloud Mobile',
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
        Text(
          Config.version,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        )
      ],
    );
  }

  void _onUserProfileTapped(BuildContext context) {
    final authManager = context.read<AuthManager>();
    authManager.getUsernameOfLoggedUser().then<void>(
          (value) => AutoRouter.of(context)
              .navigate(UserProfileRoute(username: value!)),
        );
  }

  void _onSettingsTapped(BuildContext context) =>
      AutoRouter.of(context).navigate(const SettingsRoute());

  void _onCloudSettingsTapped(BuildContext context) =>
      AutoRouter.of(context).navigate(const CloudSettingsRoute());

  void _onAboutTapped(BuildContext context) => showAboutDialog(
        context: context,
        applicationName: Config.applicationName,
        applicationLegalese: Config.applicationLegalese,
        applicationVersion: Config.version,
      );

  void _onLogoutTapped(BuildContext context) {
    context.read<AuthManager>().logout();
    AutoRouter.of(context).replaceAll([const LoginRoute()]);
  }
}
