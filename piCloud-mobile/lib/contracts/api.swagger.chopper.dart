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
  Future<Response<FileInfoDTO>> filesystemDirectoryPut(
      {required String? directoryPath}) {
    final $url = '/filesystem/directory';
    final $params = <String, dynamic>{'directoryPath': directoryPath};
    final $request = Request('PUT', $url, client.baseUrl, parameters: $params);
    return client.send<FileInfoDTO, FileInfoDTO>($request);
  }

  @override
  Future<Response<dynamic>> userNewPost({required PostUserRequest? body}) {
    final $url = '/user/new';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshRefreshTokenPost() {
    final $url = '/refresh/refresh-token';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshAuthTokenPost() {
    final $url = '/refresh/auth-token';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logoutPost() {
    final $url = '/logout';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> loginPost(
      {bool? dontLogout, required LoginRequest? body}) {
    final $url = '/login';
    final $params = <String, dynamic>{'dontLogout': dontLogout};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<FilesystemInfoDTO>> filesystemUsernameGet(
      {required String? username}) {
    final $url = '/filesystem/${username}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<FilesystemInfoDTO, FilesystemInfoDTO>($request);
  }

  @override
  Future<Response<dynamic>> filesystemUsernamePost(
      {required String? username, required int? newAssignedSpace}) {
    final $url = '/filesystem/${username}';
    final $params = <String, dynamic>{'newAssignedSpace': newAssignedSpace};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<FileInfoDTO>>> filesystemSearchPost(
      {required FileQueryDTO? body}) {
    final $url = '/filesystem/search';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<List<FileInfoDTO>, FileInfoDTO>($request);
  }

  @override
  Future<Response<FileInfoDTO>> filesImageImageNamePost(
      {required String? imageName,
      required FilesImageImageNamePost$RequestBody? body}) {
    final $url = '/files/image/${imageName}';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<FileInfoDTO, FileInfoDTO>($request);
  }

  @override
  Future<Response<FileInfoDTO>> _filesFilePost(
      {String? fileType,
      required String? filepath,
      required FilesFilePost$RequestBody? body}) {
    final $url = '/files/file';
    final $params = <String, dynamic>{
      'fileType': fileType,
      'filepath': filepath
    };
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<FileInfoDTO, FileInfoDTO>($request);
  }

  @override
  Future<Response<dynamic>> filesFileDelete() {
    final $url = '/files/file';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DriveDTO>> driveNewPost({required PostDriveRequest? body}) {
    final $url = '/drive/new';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<DriveDTO, DriveDTO>($request);
  }

  @override
  Future<Response<dynamic>> userUsernameDelete({required String? username}) {
    final $url = '/user/${username}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userUsernamePatch(
      {required String? username, required PatchUserRequest? body}) {
    final $url = '/user/${username}';
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> filesystemMovePatch(
      {required MoveFileRequest? body}) {
    final $url = '/filesystem/move';
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserDetailsDTO>>> userUsernamesDetailsGet(
      {required List<String>? usernames}) {
    final $url = '/user/${usernames}/details';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<UserDetailsDTO>, UserDetailsDTO>($request);
  }

  @override
  Future<Response<List<UserIdDTO>>> userGet() {
    final $url = '/user/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<UserIdDTO>, UserIdDTO>($request);
  }

  @override
  Future<Response<FileInfoDTO>> filesystemFileFileIdGet(
      {required String? fileId, bool? withPermissions}) {
    final $url = '/filesystem/file/${fileId}';
    final $params = <String, dynamic>{'with-permissions': withPermissions};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<FileInfoDTO, FileInfoDTO>($request);
  }

  @override
  Future<Response<FileStructureDTO>> filesystemFileStructureGet(
      {int? structureLevels, String? fileStructureRoot}) {
    final $url = '/filesystem/file-structure';
    final $params = <String, dynamic>{
      'structureLevels': structureLevels,
      'fileStructureRoot': fileStructureRoot
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<FileStructureDTO, FileStructureDTO>($request);
  }

  @override
  Future<Response<dynamic>> filesImagePreviewGet(
      {int? previewResolution, required List<String>? imageIds}) {
    final $url = '/files/image-preview';
    final $params = <String, dynamic>{
      'previewResolution': previewResolution,
      'imageIds': imageIds
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> filesFileFileIdGet({required String? fileId}) {
    final $url = '/files/file/${fileId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> filesFileFileIdDelete({required String? fileId}) {
    final $url = '/files/file/${fileId}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> filesDirectoryDirectoryIdGet(
      {required String? directoryId}) {
    final $url = '/files/directory/${directoryId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<DriveDTO>>> driveGet() {
    final $url = '/drive';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<DriveDTO>, DriveDTO>($request);
  }

  @override
  Future<Response<List<DiscDTO>>> driveDiscsGet() {
    final $url = '/drive/discs';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<DiscDTO>, DiscDTO>($request);
  }

  @override
  Future<Response<dynamic>> filesystemDirectoryDirectoryIdDelete(
      {required String? directoryId}) {
    final $url = '/filesystem/directory/${directoryId}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
