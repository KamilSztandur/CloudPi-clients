import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
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
    _bloc =
        UserProfilePageBloc(context.read<Api>(), context.read<AuthManager>());
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
              return _getContent(state.userData);
            } else if (state is UserProfilePageFetchingDataErrorState) {
              return _getErrorView();
            } else {
              return const LoadingPanel();
            }
          },
        ),
      ),
    );
  }

  ListView _getContent(UserProfileData data) {
    return ListView(
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
          height: 30,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
              ),
            ),
          ),
        ),
        ProfilePageItem(label: 'Username', value: data.username),
        ProfilePageItem(label: 'Nickname', value: data.nickname),
        ProfilePageItem(label: 'E-mail', value: data.email),
        ProfilePageItem(label: 'Roles', value: data.rolesString),
      ],
    );
  }

  Center _getErrorView() {
    return const Center(
      child: Text(
        'Error occurred!',
        style: TextStyle(fontSize: 30),
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
        context
            .read<UserProfilePageBloc>()
            .add(FetchDataErrorOccurredUserProfilePageEvent());
      } else if (state is FetchingDataFinishedUserProfilePageEvent) {
        context
            .read<UserProfilePageBloc>()
            .add(FetchingDataFinishedUserProfilePageEvent());
      }
    });
  }
}
