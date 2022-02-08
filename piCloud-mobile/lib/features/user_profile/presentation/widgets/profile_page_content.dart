import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/user_profile/bloc/user_profile_page_bloc.dart';
import 'package:app/features/user_profile/data/models/user_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_page_item.dart';

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
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
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<UserProfilePageBloc, UserProfilePageState>(
        listener: _userProfilePageBlocListener,
        child: BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
          builder: (context, state) {
            if (state is UserProfilePageFetchingDataFinishedState) {
              return _getContent(
                  state.userData, Theme.of(context).primaryColor);
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
