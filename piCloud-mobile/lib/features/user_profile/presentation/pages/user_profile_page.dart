import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/user_profile/bloc/user_profile_page_bloc.dart';
import 'package:app/features/user_profile/data/models/user_profile_data.dart';
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
      body: _getBody(),

      //bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }

  Widget _getBody() {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<UserProfilePageBloc, UserProfilePageState>(
        listener: _userProfilePageBlocListener,
        child: BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
          builder: (context, state) {
            if (state is UserProfilePageFetchingDataFinishedState) {
              return _getContent(state.userData);
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
        Text(data.username),
        Text(data.nickname),
        Text(data.email),
        Text(data.image),
        Text(data.typeOfAccount),
      ],
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
