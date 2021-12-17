import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_bloc.dart';
import 'package:app/features/user_profile/bloc/user_profile_page_bloc.dart';
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
    _initBloc();
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
      body: BlocProvider(
        create: (context) => UserProfilePageBloc(),
        child: _getBody(),
      ),
      //bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }

  Container _getBody() {
    return Container(
      child: BlocProvider.value(
        value: _bloc,
        child: BlocListener<UserProfilePageBloc, UserProfilePageState>(
          listener: (context, state) => {
            setState(() {
              if (state is UserProfilePageInitialState) {
                context
                    .read<UserProfilePageBloc>()
                    .add(InitializeUserProfilePageEvent());
              } else if (state is UserProfilePageFetchingDataState) {
                context
                    .read<UserProfilePageBloc>()
                    .add(FetchDataUserProfilePageEvent());
              } else if (state is UserProfilePageFetchingDataErrorState) {
                context
                    .read<UserProfilePageBloc>()
                    .add(FetchDataErrorOccurredUserProfilePageEvent());
              } else if (state is UserProfilePageFetchingDataFinishedState) {
                context
                    .read<UserProfilePageBloc>()
                    .add(FetchingDataFinishedUserProfilePageEvent());
              }
            })
          },
          child: BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
            builder: (context, state) {
              if (state is UserProfilePageInitialState) {
                return const Text('INIT');
              } else if (state is UserProfilePageFetchingDataState) {
                return const Text('FETCHING DATA');
              } else if (state is UserProfilePageFetchingDataErrorState) {
                return const Text('ERROR! D:');
              } else if (state is UserProfilePageFetchingDataFinishedState) {
                return Text(state.userData.username);
              } else {
                return const Text('ELSEEEEE');
              }
            },
          ),
        ),
      ),
    );
  }

  void _initBloc() {
    _bloc = UserProfilePageBloc();
    _bloc.add(FetchDataUserProfilePageEvent());
  }
}
