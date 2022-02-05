import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/user_profile/bloc/user_profile_page_bloc.dart';
import 'package:app/features/user_profile/data/models/user_profile_data.dart';
import 'package:app/features/user_profile/presentation/widgets/profile_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String title = 'User Profile';
  late UserProfilePageBloc _bloc;

  @override
  void initState() {
    _bloc = UserProfilePageBloc();
    _bloc.add(FetchDataUserProfilePageEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(
        title: title,
        actions: const [],
      ),
      drawer: const MainDrawer(),
      body: _getBody(Theme.of(context).primaryColor),

      //bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }

  Widget _getBody(Color primaryColor) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<UserProfilePageBloc, UserProfilePageState>(
        listener: _userProfilePageBlocListener,
        child: BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
          builder: (context, state) {
            if (state is UserProfilePageFetchingDataFinishedState) {
              return _getContent(state.userData, primaryColor);
            } else {
              return const LoadingPanel();
            }
          },
        ),
      ),
    );
  }

  Container _getContent(UserProfileData data, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: SizedBox(
              width: 150,
              height: 142,
              child: UserProfileImage(size: 20),
            ),
          ),
          Container(
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white38,
                ),
              ),
            ),
          ),
          ProfilePageItem(label: 'Username', value: data.username),
          ProfilePageItem(label: 'Nickname', value: data.nickname),
          ProfilePageItem(label: 'E-mail', value: data.email),
          //ProfilePageItem(label: 'image', value: data.image),
          ProfilePageItem(label: 'Account Type', value: data.typeOfAccount),
        ],
      ),
    );
  }

  void _userProfilePageBlocListener(
    BuildContext context,
    UserProfilePageState state,
  ) {
    setState(() {
      if (state is UserProfilePageInitialState) {
        context
            .read<UserProfilePageBloc>()
            .add(InitializeUserProfilePageEvent());
      } else if (state is UserProfilePageFetchingDataErrorState) {
        //TODO

      } else if (state is FetchingDataFinishedUserProfilePageEvent) {
        context
            .read<UserProfilePageBloc>()
            .add(FetchingDataFinishedUserProfilePageEvent());
      }
    });
  }
}
