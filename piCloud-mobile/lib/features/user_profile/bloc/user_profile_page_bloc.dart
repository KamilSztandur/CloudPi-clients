import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/user_profile/data/models/user_profile_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_page_event.dart';
part 'user_profile_page_state.dart';

class UserProfilePageBloc
    extends Bloc<UserProfilePageEvent, UserProfilePageState> {
  UserProfilePageBloc(this._api, this._authManager)
      : super(UserProfilePageInitialState());

  final Api _api;
  final AuthManager _authManager;
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
      final username = await _authManager.getUsernameOfLoggedUser();
      final response = await _api.userUsernameDetailsGet(username: username);
      final responseData = response.body!;
      var rolesString = '';

      for (final role in responseData.roles!) {
        final str = role.toString();
        // ignore: use_string_buffers
        rolesString += '${str.substring(str.indexOf('.') + 1)}, ';
      }

      _userData = UserProfileData(
        username: responseData.username ?? 'Unknown',
        nickname: responseData.nickname ?? 'Unknown',
        email: responseData.email ?? 'Unknown',
        rolesString: rolesString.substring(0, rolesString.length - 2),
      );

      yield UserProfilePageFetchingDataFinishedState(
        userData: _userData,
      );
    } catch (exception) {
      yield UserProfilePageFetchingDataErrorState();
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
}
