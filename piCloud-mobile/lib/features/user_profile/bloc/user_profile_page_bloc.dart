import 'dart:io';

import 'package:app/features/user_profile/data/models/user_profile_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_page_event.dart';
part 'user_profile_page_state.dart';

class UserProfilePageBloc
    extends Bloc<UserProfilePageEvent, UserProfilePageState> {
  UserProfilePageBloc() : super(UserProfilePageInitialState());

  late UserProfileData _userData;

  @override
  Stream<UserProfilePageState> mapEventToState(
    UserProfilePageEvent event,
  ) async* {
    if (event is InitializeUserProfilePageEvent) {
      yield UserProfilePageInitialState();
    } else if (event is FetchDataUserProfilePageEvent) {
      yield* _fetchingDataInProgressEvent(event);
    } else if (event is FetchDataErrorOccurredUserProfilePageEvent) {
      yield* _fetchingDataErrorEvent(event);
    } else if (event is FetchingDataFinishedUserProfilePageEvent) {
      yield* _fetchingDataFinishedEvent(event);
    }
  }

  Stream<UserProfilePageState> _fetchingDataInProgressEvent(
    FetchDataUserProfilePageEvent event,
  ) async* {
    yield UserProfilePageFetchingDataState();

    try {
      _userData = UserProfileData(
        username: await _getUsernameMock(),
        nickname: _getNickNameMock(),
        email: _getEmailMock(),
        image: _getImageMock(),
        typeOfAccount: _getTypeOfAccountMock(),
      );

      yield UserProfilePageFetchingDataFinishedState(
        userData: _userData,
      );
    } catch (exception) {
      //TODO
    }
  }

  Stream<UserProfilePageState> _fetchingDataErrorEvent(
    FetchDataErrorOccurredUserProfilePageEvent event,
  ) {
    throw UnimplementedError();
  }

  Stream<UserProfilePageState> _fetchingDataFinishedEvent(
    FetchingDataFinishedUserProfilePageEvent event,
  ) async* {
    yield UserProfilePageFetchingDataFinishedState(userData: _userData);
  }

  Future<String> _getUsernameMock() async {
    sleep(const Duration(seconds: 1));
    return 'Adam44';
  }

  String _getNickNameMock() {
    return 'w4r1ac1k';
  }

  String _getEmailMock() {
    return 'e-mail@example.ru';
  }

  String _getImageMock() {
    return 'Tu będzie obrazek';
  }

  String _getTypeOfAccountMock() {
    return 'typ konta';
  }
}
