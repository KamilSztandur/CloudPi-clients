part of 'user_profile_page_bloc.dart';

abstract class UserProfilePageEvent extends Equatable {
  const UserProfilePageEvent();

  @override
  List<Object> get props => [];
}

class InitializeUserProfilePageEvent extends UserProfilePageEvent {
  @override
  List<Object> get props => [];
}

class FetchDataUserProfilePageEvent extends UserProfilePageEvent {
  @override
  List<Object> get props => [];
}

class FetchDataErrorOccurredUserProfilePageEvent extends UserProfilePageEvent {
  @override
  List<Object> get props => [];
}

class FetchingDataFinishedUserProfilePageEvent extends UserProfilePageEvent {
  @override
  List<Object> get props => [];
}
