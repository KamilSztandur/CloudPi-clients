part of 'user_profile_page_bloc.dart';

abstract class UserProfilePageState extends Equatable {
  const UserProfilePageState();

  @override
  List<Object> get props => [];
}

class UserProfilePageInitialState extends UserProfilePageState {
  @override
  List<Object> get props => [];
}

class UserProfilePageFetchingDataState extends UserProfilePageState {
  @override
  List<Object> get props => [];
}

class UserProfilePageFetchingDataErrorState extends UserProfilePageState {
  @override
  List<Object> get props => [];
}

class UserProfilePageFetchingDataFinishedState extends UserProfilePageState {
  const UserProfilePageFetchingDataFinishedState({required this.userData});
  final UserProfileData userData;

  @override
  List<Object> get props => [userData];
}
