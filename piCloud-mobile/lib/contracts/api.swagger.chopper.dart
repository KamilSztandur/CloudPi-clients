// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Api extends Api {
  _$Api([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Api;

  @override
  Future<Response<dynamic>> _filesFilePut(
      {required String? fileType,
      required String? filepath,
      required String? file}) {
    final $url = '/files/file';
    final $params = <String, dynamic>{
      'fileType': fileType,
      'filepath': filepath,
      'file': file
    };
    final $request = Request('PUT', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _filesFilePost(
      {required String? fileType,
      required String? file,
      required String? body}) {
    final $url = '/files/file';
    final $params = <String, dynamic>{'fileType': fileType, 'file': file};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userManagementPost(
      {required PostUserRequest? body}) {
    final $url = '/user-management/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshRefreshPost() {
    final $url = '/refresh/refresh';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshAuthPost() {
    final $url = '/refresh/auth';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> loginPost({required LoginRequest? body}) {
    final $url = '/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> filesystemUsersDrivesUsernamePost(
      {required int? newAssignedSpace}) {
    final $url = '/filesystem/users-drives/{username}';
    final $params = <String, dynamic>{'newAssignedSpace': newAssignedSpace};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> filesImageImageNamePost(
      {required String? imageName, required List<String>? image}) {
    final $url = '/files/image/{imageName}';
    final $params = <String, dynamic>{'imageName': imageName, 'image': image};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> filesDirectoryPost({required String? body}) {
    final $url = '/files/directory';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> discsDiscIdUnmountPost({required int? discId}) {
    final $url = '/discs/{discId}/unmount';
    final $params = <String, dynamic>{'discId': discId};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> discsDiscIdMountPost({required int? discId}) {
    final $url = '/discs/{discId}/mount';
    final $params = <String, dynamic>{'discId': discId};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> authoritiesUserIdPost() {
    final $url = '/authorities/{userId}';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<GetUserWithDetailsResponse>> userManagementUsernameGet(
      {required String? username}) {
    final $url = '/user-management/${username}';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<GetUserWithDetailsResponse, GetUserWithDetailsResponse>($request);
  }

  @override
  Future<Response<dynamic>> userManagementUsernameDelete(
      {required String? username}) {
    final $url = '/user-management/${username}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userManagementUsernamePatch(
      {required String? username, required UpdateUserDetailsRequest? body}) {
    final $url = '/user-management/{username}';
    final $params = <String, dynamic>{'username': username};
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl,
        body: $body, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<GetUserResponse>>> userManagementGetAllGet() {
    final $url = '/user-management/get-all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetUserResponse>, GetUserResponse>($request);
  }

  @override
  Future<Response<List<GetUserWithDetailsResponse>>>
      userManagementGetAllWithDetailsGet() {
    final $url = '/user-management/get-all/with-details';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetUserWithDetailsResponse>,
        GetUserWithDetailsResponse>($request);
  }

  @override
  Future<Response<List<GetUserDriveInfo>>> filesystemUsersDrivesGet() {
    final $url = '/filesystem/users-drives';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetUserDriveInfo>, GetUserDriveInfo>($request);
  }

  @override
  Future<Response<FileStructureDTO>> filesystemUserUsernameGet(
      {required String? username,
      int? structureLevels,
      String? fileStructureRoot}) {
    final $url = '/filesystem/user/${username}';
    final $params = <String, dynamic>{
      'structureLevels': structureLevels,
      'fileStructureRoot': fileStructureRoot
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<FileStructureDTO, FileStructureDTO>($request);
  }

  @override
  Future<Response<FileDto>> filesystemInfoFileIdGet(
      {required int? fileId, required bool? withPermissions}) {
    final $url = '/filesystem/info/${fileId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<FileDto, FileDto>($request);
  }

  @override
  Future<Response<GetFilePermissionsResponse>> filesFileIdGet() {
    final $url = '/files/{fileId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<GetFilePermissionsResponse, GetFilePermissionsResponse>($request);
  }

  @override
  Future<Response<dynamic>> filesImagePreviewGet(
      {required int? previewResolution,
      required String? imageFormat,
      required List<String>? imageNames}) {
    final $url = '/files/image-preview';
    final $params = <String, dynamic>{
      'previewResolution': previewResolution,
      'imageFormat': imageFormat,
      'imageNames': imageNames
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> filesFileFileIdGet({required String? fileId}) {
    final $url = '/files/file/{fileId}';
    final $params = <String, dynamic>{'fileId': fileId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> filesFileFileIdDelete({required String? body}) {
    final $url = '/files/file/{fileId}';
    final $body = body;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> filesDirectoryDirectoryIdGet(
      {required String? directoryId}) {
    final $url = '/files/directory/{directoryId}';
    final $params = <String, dynamic>{'directoryId': directoryId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> filesDirectoryDirectoryIdDelete(
      {required String? body}) {
    final $url = '/files/directory/{directoryId}';
    final $body = body;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<GetFilePermissionsResponse>>> filesGet(
      {required List<int>? fileId}) {
    final $url = '/files/';
    final $params = <String, dynamic>{'fileId': fileId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<GetFilePermissionsResponse>,
        GetFilePermissionsResponse>($request);
  }

  @override
  Future<Response<List<DiscInfo>>> discsGet() {
    final $url = '/discs';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<DiscInfo>, DiscInfo>($request);
  }

  @override
  Future<Response<DiscDetails>> discsDiscIdGet({required int? discId}) {
    final $url = '/discs/{discId}';
    final $params = <String, dynamic>{'discId': discId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<DiscDetails, DiscDetails>($request);
  }

  @override
  Future<Response<List<DiscInfo>>> discsDriveDriveIdGet(
      {required String? driveId}) {
    final $url = '/discs/drive/{driveId}';
    final $params = <String, dynamic>{'driveId': driveId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<DiscInfo>, DiscInfo>($request);
  }

  @override
  Future<Response<GetAuthoritiesInfoResponse>>
      authoritiesUsernameCanBeGivenGet() {
    final $url = '/authorities/{username}/canBeGiven';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<GetAuthoritiesInfoResponse, GetAuthoritiesInfoResponse>($request);
  }

  @override
  Future<Response<dynamic>> authoritiesLoginGet({required String? username}) {
    final $url = '/authorities/{login}';
    final $params = <String, dynamic>{'username': username};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userManagementUsernameDeleteNowDelete(
      {required String? username}) {
    final $url = '/user-management/${username}/delete-now';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> filesDirectoryDirectoryIdForceDelete(
      {required String? body}) {
    final $url = '/files/directory/{directoryId}/force';
    final $body = body;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
