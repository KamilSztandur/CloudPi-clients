import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'api.enums.swagger.dart' as enums;
export 'api.enums.swagger.dart';

part 'api.swagger.chopper.dart';
part 'api.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Api extends ChopperService {
  static Api create([ChopperClient? client]) {
    if (client != null) {
      return _$Api(client);
    }

    final newClient = ChopperClient(
        services: [_$Api()],
        converter: $JsonSerializableConverter(),
        baseUrl: 'https://');
    return _$Api(newClient);
  }

  ///creates a directory
  ///@param directoryPath
  @Put(path: '/filesystem/directory', optionalBody: true)
  Future<chopper.Response<FileInfoDTO>> filesystemDirectoryPut(
      {@Query('directoryPath') required String? directoryPath});

  ///Downloads user's profile image
  ///@param username
  @Get(path: '/user/profile-image')
  Future<chopper.Response<String>> userProfileImageGet(
      {@Query('username') required String? username});

  ///
  @Post(path: '/user/profile-image')
  Future<chopper.Response> userProfileImagePost(
      {@Body() required UserProfileImagePost$RequestBody? body});

  ///Creates user with given values
  ///@param user JSON object of users registration data
  @Post(path: '/user/new')
  Future<chopper.Response> userNewPost(
      {@Body() required PostUserRequest? body});

  ///Gives user roles specified in request body
  @Post(path: '/roles/')
  Future<chopper.Response> rolesPost({@Body() required PostRoleRequest? body});

  ///Remove user's roles specified in request body
  @Delete(path: '/roles/')
  Future<chopper.Response> rolesDelete(
      {@Body() required DeleteRoleRequest? body});

  ///
  @Post(path: '/refresh/refresh-token', optionalBody: true)
  Future<chopper.Response> refreshRefreshTokenPost();

  ///
  @Post(path: '/refresh/auth-token', optionalBody: true)
  Future<chopper.Response> refreshAuthTokenPost();

  ///
  @Post(path: '/logout', optionalBody: true)
  Future<chopper.Response> logoutPost();

  ///
  ///@param dontLogout
  @Post(path: '/login')
  Future<chopper.Response> loginPost(
      {@Query('dontLogout') bool? dontLogout,
      @Body() required LoginRequest? body});

  ///retrieves info about virtual drive for specified user
  ///@param username
  @Get(path: '/filesystem/{username}')
  Future<chopper.Response<FilesystemInfoDTO>> filesystemUsernameGet(
      {@Path('username') required String? username});

  ///changes max space for virtual drive
  ///@param username
  ///@param newAssignedSpace
  @Post(path: '/filesystem/{username}', optionalBody: true)
  Future<chopper.Response> filesystemUsernamePost(
      {@Path('username') required String? username,
      @Query('newAssignedSpace') required int? newAssignedSpace});

  ///Takes query in request body and search for files matching given criteria
  @Post(path: '/filesystem/search')
  Future<chopper.Response<List<FileInfoDTO>>> filesystemSearchPost(
      {@Body() required FileQueryDTO? body});

  ///Not implemented: Retrieves information about requested file
  @Post(path: '/filesystem/get-by-path')
  Future<chopper.Response<FileInfoDTO>> filesystemGetByPathPost(
      {@Body() required GetFileByPathRequest? body});

  ///uploads new image
  @Post(path: '/files/image')
  Future<chopper.Response<FileInfoDTO>> filesImagePost(
      {@Body() required FilesImagePost$RequestBody? body});

  ///uploads new file, or modify it if exist
  ///@param fileType
  ///@param filepath
  Future<chopper.Response<FileInfoDTO>> filesFilePost(
      {enums.FilesFilePostFileType? fileType,
      required String? filepath,
      required FilesFilePost$RequestBody? body}) {
    return _filesFilePost(
        fileType: enums.$FilesFilePostFileTypeMap[fileType],
        filepath: filepath,
        body: body);
  }

  ///uploads new file, or modify it if exist
  ///@param fileType
  ///@param filepath
  @Post(path: '/files/file')
  Future<chopper.Response<FileInfoDTO>> _filesFilePost(
      {@Query('fileType') String? fileType,
      @Query('filepath') required String? filepath,
      @Body() required FilesFilePost$RequestBody? body});

  ///deletes files with provided UUIDs in the body
  @Delete(path: '/files/file')
  Future<chopper.Response> filesFileDelete();

  ///Add given permission to given file and user
  @Post(path: '/file-permission/permissions')
  Future<chopper.Response> filePermissionPermissionsPost(
      {@Body() required PostAddPermissionRequest? body});

  ///<h2><font color="#911">Method not implemented</font> [priority: medium]</h2>
  ///Removes permission with parameters in request body
  @Delete(path: '/file-permission/permissions')
  Future<chopper.Response> filePermissionPermissionsDelete(
      {@Body() required DeletePermissionsRequest? body});

  ///Creates new cloudpi drive in selected directory
  @Post(path: '/drive/new')
  Future<chopper.Response<DriveDTO>> driveNewPost(
      {@Body() required PostDriveRequest? body});

  ///deletes user with provided username
  ///@param username
  @Delete(path: '/user/{username}')
  Future<chopper.Response> userUsernameDelete(
      {@Path('username') required String? username});

  ///updates user with provided username
  ///@param username
  @Patch(path: '/user/{username}')
  Future<chopper.Response> userUsernamePatch(
      {@Path('username') required String? username,
      @Body() required PatchUserRequest? body});

  ///updates user's password
  @Patch(path: '/user/password')
  Future<chopper.Response> userPasswordPatch(
      {@Body() required PatchPasswordRequest? body});

  ///moves file
  @Patch(path: '/filesystem/move')
  Future<chopper.Response> filesystemMovePatch(
      {@Body() required MoveFileRequest? body});

  ///changes file's favour state
  ///@param fileId
  @Patch(path: '/favourite/{fileId}', optionalBody: true)
  Future<chopper.Response> favouriteFileIdPatch(
      {@Path('fileId') required String? fileId});

  ///returns all details of user with provided username
  ///@param usernames One or more usernames whose details you want to acquire
  ///@param username
  @Get(path: '/user/{username}/details')
  Future<chopper.Response<UserDetailsDTO>> userUsernameDetailsGet(
      {@Path('username') required String? username});

  ///Returns all users
  @Get(path: '/user/')
  Future<chopper.Response<List<UserIdDTO>>> userGet();

  ///Get all user's roles
  ///@param username
  @Get(path: '/roles/{username}')
  Future<chopper.Response> rolesUsernameGet(
      {@Path('username') required String? username});

  ///Returns list of files that was shared to user
  @Get(path: '/filesystem/files-shared-to-user')
  Future<chopper.Response<List<FileInfoDTO>>> filesystemFilesSharedToUserGet();

  ///<h2><font color="#911">Method not implemented</font> [priority: medium]</h2>
  ///Returns list of files that user shared
  @Get(path: '/filesystem/files-shared-by-user')
  Future<chopper.Response<List<FileInfoDTO>>> filesystemFilesSharedByUserGet();

  ///Retrieves information about requested file
  ///@param fileId
  ///@param with-permissions
  @Get(path: '/filesystem/file/{fileId}')
  Future<chopper.Response<FileInfoDTO>> filesystemFileFileIdGet(
      {@Path('fileId') required String? fileId,
      @Query('with-permissions') bool? withPermissions});

  ///retrieves file structure
  ///@param structureLevels
  ///@param fileStructureRoot
  @Get(path: '/filesystem/file-structure')
  Future<chopper.Response<FileStructureDTO>> filesystemFileStructureGet(
      {@Query('structureLevels') int? structureLevels,
      @Query('fileStructureRoot') required String? fileStructureRoot});

  ///creates image preview with provided resolution
  ///@param previewResolution
  ///@param imageIds
  @Get(path: '/files/image-preview')
  Future<chopper.Response> filesImagePreviewGet(
      {@Query('previewResolution') int? previewResolution,
      @Query('imageIds') required List<String>? imageIds});

  ///downloads a file
  ///@param fileId
  @Get(path: '/files/file/{fileId}')
  Future<chopper.Response<String>> filesFileFileIdGet(
      {@Path('fileId') required String? fileId});

  ///deletes a file with provided UUID
  ///@param fileId
  @Delete(path: '/files/file/{fileId}')
  Future<chopper.Response> filesFileFileIdDelete(
      {@Path('fileId') required String? fileId});

  ///compresses and returns a selected directory
  ///@param directoryId
  @Get(path: '/files/directory/{directoryId}')
  Future<chopper.Response<String>> filesDirectoryDirectoryIdGet(
      {@Path('directoryId') required String? directoryId});

  ///<h2><font color="#911">Method not implemented</font> [priority: low]</h2>
  ///Returns list of all permissions assigned to given file
  ///@param filePubId
  @Get(path: '/file-permission/permissions/{filePubId}')
  Future<chopper.Response<FilePermissionsDTO>>
      filePermissionPermissionsFilePubIdGet(
          {@Path('filePubId') required String? filePubId});

  ///<h2><font color="#911">Method not implemented</font> [priority: low]</h2>
  ///Returns permissions that user have to given file.
  ///@param filePubId
  @Get(path: '/file-permission/my-permission/{filePubId}')
  Future<chopper.Response<UserFilePermissionsDTO>>
      filePermissionMyPermissionFilePubIdGet(
          {@Path('filePubId') required String? filePubId});

  ///retrieves all files marked as favourite
  @Get(path: '/favourite/all')
  Future<chopper.Response<List<FileInfoDTO>>> favouriteAllGet();

  ///<h2><font color="#911">Method not implemented</font> [priority: low]</h2>
  ///Returns all drives
  @Get(path: '/drive')
  Future<chopper.Response<List<DriveDTO>>> driveGet();

  ///<h2><font color="#911">Method not implemented</font> [priority: low]</h2>
  ///Returns all detected discs
  @Get(path: '/drive/discs')
  Future<chopper.Response<List<DiscDTO>>> driveDiscsGet();

  ///deletes directory with provided id
  ///@param directoryId
  @Delete(path: '/filesystem/directory/{directoryId}')
  Future<chopper.Response> filesystemDirectoryDirectoryIdDelete(
      {@Path('directoryId') required String? directoryId});

  ///Removes permission all parameters for specified user and file
  @Delete(path: '/file-permission/permissions/all')
  Future<chopper.Response> filePermissionPermissionsAllDelete(
      {@Body() required DeleteAllPermissionsRequest? body});
}

final Map<Type, Object Function(Map<String, dynamic>)> ApiJsonDecoderMappings =
    {
  ErrorBody: ErrorBody.fromJsonFactory,
  FileInfoDTO: FileInfoDTO.fromJsonFactory,
  PostUserRequest: PostUserRequest.fromJsonFactory,
  PostRoleRequest: PostRoleRequest.fromJsonFactory,
  LoginRequest: LoginRequest.fromJsonFactory,
  FileQueryDTO: FileQueryDTO.fromJsonFactory,
  TimePeriod: TimePeriod.fromJsonFactory,
  GetFileByPathRequest: GetFileByPathRequest.fromJsonFactory,
  PostAddPermissionRequest: PostAddPermissionRequest.fromJsonFactory,
  PostDriveRequest: PostDriveRequest.fromJsonFactory,
  DriveDTO: DriveDTO.fromJsonFactory,
  PatchUserRequest: PatchUserRequest.fromJsonFactory,
  PatchPasswordRequest: PatchPasswordRequest.fromJsonFactory,
  MoveFileRequest: MoveFileRequest.fromJsonFactory,
  UserDetailsDTO: UserDetailsDTO.fromJsonFactory,
  UserIdDTO: UserIdDTO.fromJsonFactory,
  FilesystemInfoDTO: FilesystemInfoDTO.fromJsonFactory,
  FileStructureDTO: FileStructureDTO.fromJsonFactory,
  FilesystemObjectDTO: FilesystemObjectDTO.fromJsonFactory,
  FilePermissionsDTO: FilePermissionsDTO.fromJsonFactory,
  PermissionDTO: PermissionDTO.fromJsonFactory,
  UserFilePermissionsDTO: UserFilePermissionsDTO.fromJsonFactory,
  DiscDTO: DiscDTO.fromJsonFactory,
  DeleteRoleRequest: DeleteRoleRequest.fromJsonFactory,
  DeletePermissionsRequest: DeletePermissionsRequest.fromJsonFactory,
  DeleteAllPermissionsRequest: DeleteAllPermissionsRequest.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class ErrorBody {
  ErrorBody({
    this.errorCode,
  });

  factory ErrorBody.fromJson(Map<String, dynamic> json) =>
      _$ErrorBodyFromJson(json);

  @JsonKey(name: 'errorCode')
  final String? errorCode;
  static const fromJsonFactory = _$ErrorBodyFromJson;
  static const toJsonFactory = _$ErrorBodyToJson;
  Map<String, dynamic> toJson() => _$ErrorBodyToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorBody &&
            (identical(other.errorCode, errorCode) ||
                const DeepCollectionEquality()
                    .equals(other.errorCode, errorCode)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(errorCode) ^ runtimeType.hashCode;
}

extension $ErrorBodyExtension on ErrorBody {
  ErrorBody copyWith({String? errorCode}) {
    return ErrorBody(errorCode: errorCode ?? this.errorCode);
  }
}

@JsonSerializable(explicitToJson: true)
class FileInfoDTO {
  FileInfoDTO({
    this.pubId,
    this.name,
    this.path,
    this.hasThumbnail,
    this.type,
    this.size,
    this.modifiedAt,
    this.createdAt,
    this.isFavourite,
  });

  factory FileInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$FileInfoDTOFromJson(json);

  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'hasThumbnail')
  final bool? hasThumbnail;
  @JsonKey(
      name: 'type',
      toJson: fileInfoDTOTypeToJson,
      fromJson: fileInfoDTOTypeFromJson)
  final enums.FileInfoDTOType? type;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'modifiedAt')
  final DateTime? modifiedAt;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'isFavourite')
  final bool? isFavourite;
  static const fromJsonFactory = _$FileInfoDTOFromJson;
  static const toJsonFactory = _$FileInfoDTOToJson;
  Map<String, dynamic> toJson() => _$FileInfoDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileInfoDTO &&
            (identical(other.pubId, pubId) ||
                const DeepCollectionEquality().equals(other.pubId, pubId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.hasThumbnail, hasThumbnail) ||
                const DeepCollectionEquality()
                    .equals(other.hasThumbnail, hasThumbnail)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.modifiedAt, modifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.modifiedAt, modifiedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.isFavourite, isFavourite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavourite, isFavourite)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(hasThumbnail) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(isFavourite) ^
      runtimeType.hashCode;
}

extension $FileInfoDTOExtension on FileInfoDTO {
  FileInfoDTO copyWith(
      {String? pubId,
      String? name,
      String? path,
      bool? hasThumbnail,
      enums.FileInfoDTOType? type,
      int? size,
      DateTime? modifiedAt,
      DateTime? createdAt,
      bool? isFavourite}) {
    return FileInfoDTO(
        pubId: pubId ?? this.pubId,
        name: name ?? this.name,
        path: path ?? this.path,
        hasThumbnail: hasThumbnail ?? this.hasThumbnail,
        type: type ?? this.type,
        size: size ?? this.size,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdAt: createdAt ?? this.createdAt,
        isFavourite: isFavourite ?? this.isFavourite);
  }
}

@JsonSerializable(explicitToJson: true)
class PostUserRequest {
  PostUserRequest({
    this.username,
    this.nickname,
    this.email,
    this.password,
  });

  factory PostUserRequest.fromJson(Map<String, dynamic> json) =>
      _$PostUserRequestFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  static const fromJsonFactory = _$PostUserRequestFromJson;
  static const toJsonFactory = _$PostUserRequestToJson;
  Map<String, dynamic> toJson() => _$PostUserRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostUserRequest &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $PostUserRequestExtension on PostUserRequest {
  PostUserRequest copyWith(
      {String? username, String? nickname, String? email, String? password}) {
    return PostUserRequest(
        username: username ?? this.username,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        password: password ?? this.password);
  }
}

@JsonSerializable(explicitToJson: true)
class PostRoleRequest {
  PostRoleRequest({
    this.roles,
    this.username,
  });

  factory PostRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$PostRoleRequestFromJson(json);

  @JsonKey(
      name: 'roles',
      toJson: postRoleRequestRolesListToJson,
      fromJson: postRoleRequestRolesListFromJson)
  final List<enums.PostRoleRequestRoles>? roles;
  @JsonKey(name: 'username')
  final String? username;
  static const fromJsonFactory = _$PostRoleRequestFromJson;
  static const toJsonFactory = _$PostRoleRequestToJson;
  Map<String, dynamic> toJson() => _$PostRoleRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostRoleRequest &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(roles) ^
      const DeepCollectionEquality().hash(username) ^
      runtimeType.hashCode;
}

extension $PostRoleRequestExtension on PostRoleRequest {
  PostRoleRequest copyWith(
      {List<enums.PostRoleRequestRoles>? roles, String? username}) {
    return PostRoleRequest(
        roles: roles ?? this.roles, username: username ?? this.username);
  }
}

@JsonSerializable(explicitToJson: true)
class LoginRequest {
  LoginRequest({
    this.username,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  static const fromJsonFactory = _$LoginRequestFromJson;
  static const toJsonFactory = _$LoginRequestToJson;
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginRequest &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $LoginRequestExtension on LoginRequest {
  LoginRequest copyWith({String? username, String? password}) {
    return LoginRequest(
        username: username ?? this.username,
        password: password ?? this.password);
  }
}

@JsonSerializable(explicitToJson: true)
class FileQueryDTO {
  FileQueryDTO({
    this.name,
    this.path,
    this.types,
    this.created,
    this.lastModified,
  });

  factory FileQueryDTO.fromJson(Map<String, dynamic> json) =>
      _$FileQueryDTOFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(
      name: 'types',
      toJson: fileQueryDTOTypesListToJson,
      fromJson: fileQueryDTOTypesListFromJson)
  final List<enums.FileQueryDTOTypes>? types;
  @JsonKey(name: 'created')
  final TimePeriod? created;
  @JsonKey(name: 'lastModified')
  final TimePeriod? lastModified;
  static const fromJsonFactory = _$FileQueryDTOFromJson;
  static const toJsonFactory = _$FileQueryDTOToJson;
  Map<String, dynamic> toJson() => _$FileQueryDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileQueryDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.lastModified, lastModified) ||
                const DeepCollectionEquality()
                    .equals(other.lastModified, lastModified)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(lastModified) ^
      runtimeType.hashCode;
}

extension $FileQueryDTOExtension on FileQueryDTO {
  FileQueryDTO copyWith(
      {String? name,
      String? path,
      List<enums.FileQueryDTOTypes>? types,
      TimePeriod? created,
      TimePeriod? lastModified}) {
    return FileQueryDTO(
        name: name ?? this.name,
        path: path ?? this.path,
        types: types ?? this.types,
        created: created ?? this.created,
        lastModified: lastModified ?? this.lastModified);
  }
}

@JsonSerializable(explicitToJson: true)
class TimePeriod {
  TimePeriod({
    this.from,
    this.to,
  });

  factory TimePeriod.fromJson(Map<String, dynamic> json) =>
      _$TimePeriodFromJson(json);

  @JsonKey(name: 'from')
  final DateTime? from;
  @JsonKey(name: 'to')
  final DateTime? to;
  static const fromJsonFactory = _$TimePeriodFromJson;
  static const toJsonFactory = _$TimePeriodToJson;
  Map<String, dynamic> toJson() => _$TimePeriodToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TimePeriod &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      runtimeType.hashCode;
}

extension $TimePeriodExtension on TimePeriod {
  TimePeriod copyWith({DateTime? from, DateTime? to}) {
    return TimePeriod(from: from ?? this.from, to: to ?? this.to);
  }
}

@JsonSerializable(explicitToJson: true)
class GetFileByPathRequest {
  GetFileByPathRequest({
    this.filePaths,
  });

  factory GetFileByPathRequest.fromJson(Map<String, dynamic> json) =>
      _$GetFileByPathRequestFromJson(json);

  @JsonKey(name: 'filePaths', defaultValue: <String>[])
  final List<String>? filePaths;
  static const fromJsonFactory = _$GetFileByPathRequestFromJson;
  static const toJsonFactory = _$GetFileByPathRequestToJson;
  Map<String, dynamic> toJson() => _$GetFileByPathRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetFileByPathRequest &&
            (identical(other.filePaths, filePaths) ||
                const DeepCollectionEquality()
                    .equals(other.filePaths, filePaths)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePaths) ^ runtimeType.hashCode;
}

extension $GetFileByPathRequestExtension on GetFileByPathRequest {
  GetFileByPathRequest copyWith({List<String>? filePaths}) {
    return GetFileByPathRequest(filePaths: filePaths ?? this.filePaths);
  }
}

@JsonSerializable(explicitToJson: true)
class PostAddPermissionRequest {
  PostAddPermissionRequest({
    this.filePubId,
    this.ownerUsername,
    this.permissions,
  });

  factory PostAddPermissionRequest.fromJson(Map<String, dynamic> json) =>
      _$PostAddPermissionRequestFromJson(json);

  @JsonKey(name: 'filePubId')
  final String? filePubId;
  @JsonKey(name: 'ownerUsername')
  final String? ownerUsername;
  @JsonKey(
      name: 'permissions',
      toJson: postAddPermissionRequestPermissionsListToJson,
      fromJson: postAddPermissionRequestPermissionsListFromJson)
  final List<enums.PostAddPermissionRequestPermissions>? permissions;
  static const fromJsonFactory = _$PostAddPermissionRequestFromJson;
  static const toJsonFactory = _$PostAddPermissionRequestToJson;
  Map<String, dynamic> toJson() => _$PostAddPermissionRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostAddPermissionRequest &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)) &&
            (identical(other.ownerUsername, ownerUsername) ||
                const DeepCollectionEquality()
                    .equals(other.ownerUsername, ownerUsername)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePubId) ^
      const DeepCollectionEquality().hash(ownerUsername) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $PostAddPermissionRequestExtension on PostAddPermissionRequest {
  PostAddPermissionRequest copyWith(
      {String? filePubId,
      String? ownerUsername,
      List<enums.PostAddPermissionRequestPermissions>? permissions}) {
    return PostAddPermissionRequest(
        filePubId: filePubId ?? this.filePubId,
        ownerUsername: ownerUsername ?? this.ownerUsername,
        permissions: permissions ?? this.permissions);
  }
}

@JsonSerializable(explicitToJson: true)
class PostDriveRequest {
  PostDriveRequest({
    this.path,
    this.size,
  });

  factory PostDriveRequest.fromJson(Map<String, dynamic> json) =>
      _$PostDriveRequestFromJson(json);

  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'size')
  final int? size;
  static const fromJsonFactory = _$PostDriveRequestFromJson;
  static const toJsonFactory = _$PostDriveRequestToJson;
  Map<String, dynamic> toJson() => _$PostDriveRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostDriveRequest &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(size) ^
      runtimeType.hashCode;
}

extension $PostDriveRequestExtension on PostDriveRequest {
  PostDriveRequest copyWith({String? path, int? size}) {
    return PostDriveRequest(path: path ?? this.path, size: size ?? this.size);
  }
}

@JsonSerializable(explicitToJson: true)
class DriveDTO {
  DriveDTO({
    this.pubId,
    this.path,
    this.assignedSpace,
    this.freeSpace,
  });

  factory DriveDTO.fromJson(Map<String, dynamic> json) =>
      _$DriveDTOFromJson(json);

  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'assignedSpace')
  final int? assignedSpace;
  @JsonKey(name: 'freeSpace')
  final int? freeSpace;
  static const fromJsonFactory = _$DriveDTOFromJson;
  static const toJsonFactory = _$DriveDTOToJson;
  Map<String, dynamic> toJson() => _$DriveDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DriveDTO &&
            (identical(other.pubId, pubId) ||
                const DeepCollectionEquality().equals(other.pubId, pubId)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.assignedSpace, assignedSpace) ||
                const DeepCollectionEquality()
                    .equals(other.assignedSpace, assignedSpace)) &&
            (identical(other.freeSpace, freeSpace) ||
                const DeepCollectionEquality()
                    .equals(other.freeSpace, freeSpace)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(assignedSpace) ^
      const DeepCollectionEquality().hash(freeSpace) ^
      runtimeType.hashCode;
}

extension $DriveDTOExtension on DriveDTO {
  DriveDTO copyWith(
      {String? pubId, String? path, int? assignedSpace, int? freeSpace}) {
    return DriveDTO(
        pubId: pubId ?? this.pubId,
        path: path ?? this.path,
        assignedSpace: assignedSpace ?? this.assignedSpace,
        freeSpace: freeSpace ?? this.freeSpace);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchUserRequest {
  PatchUserRequest({
    this.nickname,
    this.email,
  });

  factory PatchUserRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchUserRequestFromJson(json);

  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$PatchUserRequestFromJson;
  static const toJsonFactory = _$PatchUserRequestToJson;
  Map<String, dynamic> toJson() => _$PatchUserRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchUserRequest &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $PatchUserRequestExtension on PatchUserRequest {
  PatchUserRequest copyWith({String? nickname, String? email}) {
    return PatchUserRequest(
        nickname: nickname ?? this.nickname, email: email ?? this.email);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchPasswordRequest {
  PatchPasswordRequest({
    this.currentPassword,
    this.newPassword,
  });

  factory PatchPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchPasswordRequestFromJson(json);

  @JsonKey(name: 'currentPassword')
  final String? currentPassword;
  @JsonKey(name: 'newPassword')
  final String? newPassword;
  static const fromJsonFactory = _$PatchPasswordRequestFromJson;
  static const toJsonFactory = _$PatchPasswordRequestToJson;
  Map<String, dynamic> toJson() => _$PatchPasswordRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchPasswordRequest &&
            (identical(other.currentPassword, currentPassword) ||
                const DeepCollectionEquality()
                    .equals(other.currentPassword, currentPassword)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality()
                    .equals(other.newPassword, newPassword)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currentPassword) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $PatchPasswordRequestExtension on PatchPasswordRequest {
  PatchPasswordRequest copyWith(
      {String? currentPassword, String? newPassword}) {
    return PatchPasswordRequest(
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword);
  }
}

@JsonSerializable(explicitToJson: true)
class MoveFileRequest {
  MoveFileRequest({
    this.filePubId,
    this.newPath,
  });

  factory MoveFileRequest.fromJson(Map<String, dynamic> json) =>
      _$MoveFileRequestFromJson(json);

  @JsonKey(name: 'filePubId')
  final String? filePubId;
  @JsonKey(name: 'newPath')
  final String? newPath;
  static const fromJsonFactory = _$MoveFileRequestFromJson;
  static const toJsonFactory = _$MoveFileRequestToJson;
  Map<String, dynamic> toJson() => _$MoveFileRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoveFileRequest &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)) &&
            (identical(other.newPath, newPath) ||
                const DeepCollectionEquality().equals(other.newPath, newPath)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePubId) ^
      const DeepCollectionEquality().hash(newPath) ^
      runtimeType.hashCode;
}

extension $MoveFileRequestExtension on MoveFileRequest {
  MoveFileRequest copyWith({String? filePubId, String? newPath}) {
    return MoveFileRequest(
        filePubId: filePubId ?? this.filePubId,
        newPath: newPath ?? this.newPath);
  }
}

@JsonSerializable(explicitToJson: true)
class UserDetailsDTO {
  UserDetailsDTO({
    this.username,
    this.email,
    this.hasProfileImage,
    this.nickname,
    this.pubId,
    this.roles,
  });

  factory UserDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsDTOFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'hasProfileImage')
  final bool? hasProfileImage;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(
      name: 'roles',
      toJson: userDetailsDTORolesListToJson,
      fromJson: userDetailsDTORolesListFromJson)
  final List<enums.UserDetailsDTORoles>? roles;
  static const fromJsonFactory = _$UserDetailsDTOFromJson;
  static const toJsonFactory = _$UserDetailsDTOToJson;
  Map<String, dynamic> toJson() => _$UserDetailsDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDetailsDTO &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.hasProfileImage, hasProfileImage) ||
                const DeepCollectionEquality()
                    .equals(other.hasProfileImage, hasProfileImage)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.pubId, pubId) ||
                const DeepCollectionEquality().equals(other.pubId, pubId)) &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(hasProfileImage) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(roles) ^
      runtimeType.hashCode;
}

extension $UserDetailsDTOExtension on UserDetailsDTO {
  UserDetailsDTO copyWith(
      {String? username,
      String? email,
      bool? hasProfileImage,
      String? nickname,
      String? pubId,
      List<enums.UserDetailsDTORoles>? roles}) {
    return UserDetailsDTO(
        username: username ?? this.username,
        email: email ?? this.email,
        hasProfileImage: hasProfileImage ?? this.hasProfileImage,
        nickname: nickname ?? this.nickname,
        pubId: pubId ?? this.pubId,
        roles: roles ?? this.roles);
  }
}

@JsonSerializable(explicitToJson: true)
class UserIdDTO {
  UserIdDTO({
    this.username,
    this.pubId,
    this.nickname,
    this.hasProfileImage,
  });

  factory UserIdDTO.fromJson(Map<String, dynamic> json) =>
      _$UserIdDTOFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'hasProfileImage')
  final bool? hasProfileImage;
  static const fromJsonFactory = _$UserIdDTOFromJson;
  static const toJsonFactory = _$UserIdDTOToJson;
  Map<String, dynamic> toJson() => _$UserIdDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserIdDTO &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.pubId, pubId) ||
                const DeepCollectionEquality().equals(other.pubId, pubId)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.hasProfileImage, hasProfileImage) ||
                const DeepCollectionEquality()
                    .equals(other.hasProfileImage, hasProfileImage)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(hasProfileImage) ^
      runtimeType.hashCode;
}

extension $UserIdDTOExtension on UserIdDTO {
  UserIdDTO copyWith(
      {String? username,
      String? pubId,
      String? nickname,
      bool? hasProfileImage}) {
    return UserIdDTO(
        username: username ?? this.username,
        pubId: pubId ?? this.pubId,
        nickname: nickname ?? this.nickname,
        hasProfileImage: hasProfileImage ?? this.hasProfileImage);
  }
}

@JsonSerializable(explicitToJson: true)
class FilesystemInfoDTO {
  FilesystemInfoDTO({
    this.ownerUsername,
    this.totalSpace,
    this.freeSpace,
  });

  factory FilesystemInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$FilesystemInfoDTOFromJson(json);

  @JsonKey(name: 'ownerUsername')
  final String? ownerUsername;
  @JsonKey(name: 'totalSpace')
  final int? totalSpace;
  @JsonKey(name: 'freeSpace')
  final int? freeSpace;
  static const fromJsonFactory = _$FilesystemInfoDTOFromJson;
  static const toJsonFactory = _$FilesystemInfoDTOToJson;
  Map<String, dynamic> toJson() => _$FilesystemInfoDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilesystemInfoDTO &&
            (identical(other.ownerUsername, ownerUsername) ||
                const DeepCollectionEquality()
                    .equals(other.ownerUsername, ownerUsername)) &&
            (identical(other.totalSpace, totalSpace) ||
                const DeepCollectionEquality()
                    .equals(other.totalSpace, totalSpace)) &&
            (identical(other.freeSpace, freeSpace) ||
                const DeepCollectionEquality()
                    .equals(other.freeSpace, freeSpace)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ownerUsername) ^
      const DeepCollectionEquality().hash(totalSpace) ^
      const DeepCollectionEquality().hash(freeSpace) ^
      runtimeType.hashCode;
}

extension $FilesystemInfoDTOExtension on FilesystemInfoDTO {
  FilesystemInfoDTO copyWith(
      {String? ownerUsername, int? totalSpace, int? freeSpace}) {
    return FilesystemInfoDTO(
        ownerUsername: ownerUsername ?? this.ownerUsername,
        totalSpace: totalSpace ?? this.totalSpace,
        freeSpace: freeSpace ?? this.freeSpace);
  }
}

@JsonSerializable(explicitToJson: true)
class FileStructureDTO {
  FileStructureDTO({
    this.path,
    this.root,
  });

  factory FileStructureDTO.fromJson(Map<String, dynamic> json) =>
      _$FileStructureDTOFromJson(json);

  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'root')
  final FilesystemObjectDTO? root;
  static const fromJsonFactory = _$FileStructureDTOFromJson;
  static const toJsonFactory = _$FileStructureDTOToJson;
  Map<String, dynamic> toJson() => _$FileStructureDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileStructureDTO &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(root) ^
      runtimeType.hashCode;
}

extension $FileStructureDTOExtension on FileStructureDTO {
  FileStructureDTO copyWith({String? path, FilesystemObjectDTO? root}) {
    return FileStructureDTO(path: path ?? this.path, root: root ?? this.root);
  }
}

@JsonSerializable(explicitToJson: true)
class FilesystemObjectDTO {
  FilesystemObjectDTO({
    this.pubId,
    this.name,
    this.size,
    this.modifiedAt,
    this.version,
    this.type,
    this.children,
  });

  factory FilesystemObjectDTO.fromJson(Map<String, dynamic> json) =>
      _$FilesystemObjectDTOFromJson(json);

  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'modifiedAt')
  final DateTime? modifiedAt;
  @JsonKey(name: 'version')
  final int? version;
  @JsonKey(
      name: 'type',
      toJson: filesystemObjectDTOTypeToJson,
      fromJson: filesystemObjectDTOTypeFromJson)
  final enums.FilesystemObjectDTOType? type;
  @JsonKey(name: 'children', defaultValue: <FilesystemObjectDTO>[])
  final List<FilesystemObjectDTO>? children;
  static const fromJsonFactory = _$FilesystemObjectDTOFromJson;
  static const toJsonFactory = _$FilesystemObjectDTOToJson;
  Map<String, dynamic> toJson() => _$FilesystemObjectDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilesystemObjectDTO &&
            (identical(other.pubId, pubId) ||
                const DeepCollectionEquality().equals(other.pubId, pubId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.modifiedAt, modifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.modifiedAt, modifiedAt)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.children, children) ||
                const DeepCollectionEquality()
                    .equals(other.children, children)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(children) ^
      runtimeType.hashCode;
}

extension $FilesystemObjectDTOExtension on FilesystemObjectDTO {
  FilesystemObjectDTO copyWith(
      {String? pubId,
      String? name,
      int? size,
      DateTime? modifiedAt,
      int? version,
      enums.FilesystemObjectDTOType? type,
      List<FilesystemObjectDTO>? children}) {
    return FilesystemObjectDTO(
        pubId: pubId ?? this.pubId,
        name: name ?? this.name,
        size: size ?? this.size,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        version: version ?? this.version,
        type: type ?? this.type,
        children: children ?? this.children);
  }
}

@JsonSerializable(explicitToJson: true)
class FilePermissionsDTO {
  FilePermissionsDTO({
    this.filePubId,
    this.permissions,
  });

  factory FilePermissionsDTO.fromJson(Map<String, dynamic> json) =>
      _$FilePermissionsDTOFromJson(json);

  @JsonKey(name: 'filePubId')
  final String? filePubId;
  @JsonKey(name: 'permissions', defaultValue: <PermissionDTO>[])
  final List<PermissionDTO>? permissions;
  static const fromJsonFactory = _$FilePermissionsDTOFromJson;
  static const toJsonFactory = _$FilePermissionsDTOToJson;
  Map<String, dynamic> toJson() => _$FilePermissionsDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilePermissionsDTO &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePubId) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $FilePermissionsDTOExtension on FilePermissionsDTO {
  FilePermissionsDTO copyWith(
      {String? filePubId, List<PermissionDTO>? permissions}) {
    return FilePermissionsDTO(
        filePubId: filePubId ?? this.filePubId,
        permissions: permissions ?? this.permissions);
  }
}

@JsonSerializable(explicitToJson: true)
class PermissionDTO {
  PermissionDTO({
    this.ownerUsername,
    this.permissions,
  });

  factory PermissionDTO.fromJson(Map<String, dynamic> json) =>
      _$PermissionDTOFromJson(json);

  @JsonKey(name: 'ownerUsername')
  final String? ownerUsername;
  @JsonKey(
      name: 'permissions',
      toJson: permissionDTOPermissionsListToJson,
      fromJson: permissionDTOPermissionsListFromJson)
  final List<enums.PermissionDTOPermissions>? permissions;
  static const fromJsonFactory = _$PermissionDTOFromJson;
  static const toJsonFactory = _$PermissionDTOToJson;
  Map<String, dynamic> toJson() => _$PermissionDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PermissionDTO &&
            (identical(other.ownerUsername, ownerUsername) ||
                const DeepCollectionEquality()
                    .equals(other.ownerUsername, ownerUsername)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ownerUsername) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $PermissionDTOExtension on PermissionDTO {
  PermissionDTO copyWith(
      {String? ownerUsername,
      List<enums.PermissionDTOPermissions>? permissions}) {
    return PermissionDTO(
        ownerUsername: ownerUsername ?? this.ownerUsername,
        permissions: permissions ?? this.permissions);
  }
}

@JsonSerializable(explicitToJson: true)
class UserFilePermissionsDTO {
  UserFilePermissionsDTO({
    this.types,
    this.username,
    this.filePubId,
  });

  factory UserFilePermissionsDTO.fromJson(Map<String, dynamic> json) =>
      _$UserFilePermissionsDTOFromJson(json);

  @JsonKey(
      name: 'types',
      toJson: userFilePermissionsDTOTypesListToJson,
      fromJson: userFilePermissionsDTOTypesListFromJson)
  final List<enums.UserFilePermissionsDTOTypes>? types;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'filePubId')
  final String? filePubId;
  static const fromJsonFactory = _$UserFilePermissionsDTOFromJson;
  static const toJsonFactory = _$UserFilePermissionsDTOToJson;
  Map<String, dynamic> toJson() => _$UserFilePermissionsDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserFilePermissionsDTO &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(filePubId) ^
      runtimeType.hashCode;
}

extension $UserFilePermissionsDTOExtension on UserFilePermissionsDTO {
  UserFilePermissionsDTO copyWith(
      {List<enums.UserFilePermissionsDTOTypes>? types,
      String? username,
      String? filePubId}) {
    return UserFilePermissionsDTO(
        types: types ?? this.types,
        username: username ?? this.username,
        filePubId: filePubId ?? this.filePubId);
  }
}

@JsonSerializable(explicitToJson: true)
class DiscDTO {
  DiscDTO({
    this.discName,
    this.discSize,
    this.discSpaceAvailable,
  });

  factory DiscDTO.fromJson(Map<String, dynamic> json) =>
      _$DiscDTOFromJson(json);

  @JsonKey(name: 'discName')
  final String? discName;
  @JsonKey(name: 'discSize')
  final int? discSize;
  @JsonKey(name: 'discSpaceAvailable')
  final int? discSpaceAvailable;
  static const fromJsonFactory = _$DiscDTOFromJson;
  static const toJsonFactory = _$DiscDTOToJson;
  Map<String, dynamic> toJson() => _$DiscDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscDTO &&
            (identical(other.discName, discName) ||
                const DeepCollectionEquality()
                    .equals(other.discName, discName)) &&
            (identical(other.discSize, discSize) ||
                const DeepCollectionEquality()
                    .equals(other.discSize, discSize)) &&
            (identical(other.discSpaceAvailable, discSpaceAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.discSpaceAvailable, discSpaceAvailable)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(discName) ^
      const DeepCollectionEquality().hash(discSize) ^
      const DeepCollectionEquality().hash(discSpaceAvailable) ^
      runtimeType.hashCode;
}

extension $DiscDTOExtension on DiscDTO {
  DiscDTO copyWith({String? discName, int? discSize, int? discSpaceAvailable}) {
    return DiscDTO(
        discName: discName ?? this.discName,
        discSize: discSize ?? this.discSize,
        discSpaceAvailable: discSpaceAvailable ?? this.discSpaceAvailable);
  }
}

@JsonSerializable(explicitToJson: true)
class DeleteRoleRequest {
  DeleteRoleRequest({
    this.roles,
    this.username,
  });

  factory DeleteRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteRoleRequestFromJson(json);

  @JsonKey(
      name: 'roles',
      toJson: deleteRoleRequestRolesListToJson,
      fromJson: deleteRoleRequestRolesListFromJson)
  final List<enums.DeleteRoleRequestRoles>? roles;
  @JsonKey(name: 'username')
  final String? username;
  static const fromJsonFactory = _$DeleteRoleRequestFromJson;
  static const toJsonFactory = _$DeleteRoleRequestToJson;
  Map<String, dynamic> toJson() => _$DeleteRoleRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeleteRoleRequest &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(roles) ^
      const DeepCollectionEquality().hash(username) ^
      runtimeType.hashCode;
}

extension $DeleteRoleRequestExtension on DeleteRoleRequest {
  DeleteRoleRequest copyWith(
      {List<enums.DeleteRoleRequestRoles>? roles, String? username}) {
    return DeleteRoleRequest(
        roles: roles ?? this.roles, username: username ?? this.username);
  }
}

@JsonSerializable(explicitToJson: true)
class DeletePermissionsRequest {
  DeletePermissionsRequest({
    this.filePubId,
    this.ownerUsername,
    this.permissions,
  });

  factory DeletePermissionsRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePermissionsRequestFromJson(json);

  @JsonKey(name: 'filePubId')
  final String? filePubId;
  @JsonKey(name: 'ownerUsername')
  final String? ownerUsername;
  @JsonKey(
      name: 'permissions',
      toJson: deletePermissionsRequestPermissionsListToJson,
      fromJson: deletePermissionsRequestPermissionsListFromJson)
  final List<enums.DeletePermissionsRequestPermissions>? permissions;
  static const fromJsonFactory = _$DeletePermissionsRequestFromJson;
  static const toJsonFactory = _$DeletePermissionsRequestToJson;
  Map<String, dynamic> toJson() => _$DeletePermissionsRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeletePermissionsRequest &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)) &&
            (identical(other.ownerUsername, ownerUsername) ||
                const DeepCollectionEquality()
                    .equals(other.ownerUsername, ownerUsername)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePubId) ^
      const DeepCollectionEquality().hash(ownerUsername) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $DeletePermissionsRequestExtension on DeletePermissionsRequest {
  DeletePermissionsRequest copyWith(
      {String? filePubId,
      String? ownerUsername,
      List<enums.DeletePermissionsRequestPermissions>? permissions}) {
    return DeletePermissionsRequest(
        filePubId: filePubId ?? this.filePubId,
        ownerUsername: ownerUsername ?? this.ownerUsername,
        permissions: permissions ?? this.permissions);
  }
}

@JsonSerializable(explicitToJson: true)
class DeleteAllPermissionsRequest {
  DeleteAllPermissionsRequest({
    this.filePubId,
  });

  factory DeleteAllPermissionsRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAllPermissionsRequestFromJson(json);

  @JsonKey(name: 'filePubId')
  final String? filePubId;
  static const fromJsonFactory = _$DeleteAllPermissionsRequestFromJson;
  static const toJsonFactory = _$DeleteAllPermissionsRequestToJson;
  Map<String, dynamic> toJson() => _$DeleteAllPermissionsRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeleteAllPermissionsRequest &&
            (identical(other.filePubId, filePubId) ||
                const DeepCollectionEquality()
                    .equals(other.filePubId, filePubId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filePubId) ^ runtimeType.hashCode;
}

extension $DeleteAllPermissionsRequestExtension on DeleteAllPermissionsRequest {
  DeleteAllPermissionsRequest copyWith({String? filePubId}) {
    return DeleteAllPermissionsRequest(filePubId: filePubId ?? this.filePubId);
  }
}

String? filesFilePostFileTypeToJson(
    enums.FilesFilePostFileType? filesFilePostFileType) {
  return enums.$FilesFilePostFileTypeMap[filesFilePostFileType];
}

enums.FilesFilePostFileType filesFilePostFileTypeFromJson(
    String? filesFilePostFileType) {
  if (filesFilePostFileType == null) {
    return enums.FilesFilePostFileType.swaggerGeneratedUnknown;
  }

  return enums.$FilesFilePostFileTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              filesFilePostFileType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.FilesFilePostFileType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> filesFilePostFileTypeListToJson(
    List<enums.FilesFilePostFileType>? filesFilePostFileType) {
  if (filesFilePostFileType == null) {
    return [];
  }

  return filesFilePostFileType
      .map((e) => enums.$FilesFilePostFileTypeMap[e]!)
      .toList();
}

List<enums.FilesFilePostFileType> filesFilePostFileTypeListFromJson(
    List? filesFilePostFileType) {
  if (filesFilePostFileType == null) {
    return [];
  }

  return filesFilePostFileType
      .map((e) => filesFilePostFileTypeFromJson(e.toString()))
      .toList();
}

String? fileInfoDTOTypeToJson(enums.FileInfoDTOType? fileInfoDTOType) {
  return enums.$FileInfoDTOTypeMap[fileInfoDTOType];
}

enums.FileInfoDTOType fileInfoDTOTypeFromJson(String? fileInfoDTOType) {
  if (fileInfoDTOType == null) {
    return enums.FileInfoDTOType.swaggerGeneratedUnknown;
  }

  return enums.$FileInfoDTOTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == fileInfoDTOType.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.FileInfoDTOType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> fileInfoDTOTypeListToJson(
    List<enums.FileInfoDTOType>? fileInfoDTOType) {
  if (fileInfoDTOType == null) {
    return [];
  }

  return fileInfoDTOType.map((e) => enums.$FileInfoDTOTypeMap[e]!).toList();
}

List<enums.FileInfoDTOType> fileInfoDTOTypeListFromJson(List? fileInfoDTOType) {
  if (fileInfoDTOType == null) {
    return [];
  }

  return fileInfoDTOType
      .map((e) => fileInfoDTOTypeFromJson(e.toString()))
      .toList();
}

String? postRoleRequestRolesToJson(
    enums.PostRoleRequestRoles? postRoleRequestRoles) {
  return enums.$PostRoleRequestRolesMap[postRoleRequestRoles];
}

enums.PostRoleRequestRoles postRoleRequestRolesFromJson(
    String? postRoleRequestRoles) {
  if (postRoleRequestRoles == null) {
    return enums.PostRoleRequestRoles.swaggerGeneratedUnknown;
  }

  return enums.$PostRoleRequestRolesMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == postRoleRequestRoles.toLowerCase(),
          orElse: () => const MapEntry(
              enums.PostRoleRequestRoles.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> postRoleRequestRolesListToJson(
    List<enums.PostRoleRequestRoles>? postRoleRequestRoles) {
  if (postRoleRequestRoles == null) {
    return [];
  }

  return postRoleRequestRoles
      .map((e) => enums.$PostRoleRequestRolesMap[e]!)
      .toList();
}

List<enums.PostRoleRequestRoles> postRoleRequestRolesListFromJson(
    List? postRoleRequestRoles) {
  if (postRoleRequestRoles == null) {
    return [];
  }

  return postRoleRequestRoles
      .map((e) => postRoleRequestRolesFromJson(e.toString()))
      .toList();
}

String? fileQueryDTOTypesToJson(enums.FileQueryDTOTypes? fileQueryDTOTypes) {
  return enums.$FileQueryDTOTypesMap[fileQueryDTOTypes];
}

enums.FileQueryDTOTypes fileQueryDTOTypesFromJson(String? fileQueryDTOTypes) {
  if (fileQueryDTOTypes == null) {
    return enums.FileQueryDTOTypes.swaggerGeneratedUnknown;
  }

  return enums.$FileQueryDTOTypesMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == fileQueryDTOTypes.toLowerCase(),
          orElse: () => const MapEntry(
              enums.FileQueryDTOTypes.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> fileQueryDTOTypesListToJson(
    List<enums.FileQueryDTOTypes>? fileQueryDTOTypes) {
  if (fileQueryDTOTypes == null) {
    return [];
  }

  return fileQueryDTOTypes.map((e) => enums.$FileQueryDTOTypesMap[e]!).toList();
}

List<enums.FileQueryDTOTypes> fileQueryDTOTypesListFromJson(
    List? fileQueryDTOTypes) {
  if (fileQueryDTOTypes == null) {
    return [];
  }

  return fileQueryDTOTypes
      .map((e) => fileQueryDTOTypesFromJson(e.toString()))
      .toList();
}

String? postAddPermissionRequestPermissionsToJson(
    enums.PostAddPermissionRequestPermissions?
        postAddPermissionRequestPermissions) {
  return enums.$PostAddPermissionRequestPermissionsMap[
      postAddPermissionRequestPermissions];
}

enums.PostAddPermissionRequestPermissions
    postAddPermissionRequestPermissionsFromJson(
        String? postAddPermissionRequestPermissions) {
  if (postAddPermissionRequestPermissions == null) {
    return enums.PostAddPermissionRequestPermissions.swaggerGeneratedUnknown;
  }

  return enums.$PostAddPermissionRequestPermissionsMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              postAddPermissionRequestPermissions.toLowerCase(),
          orElse: () => const MapEntry(
              enums.PostAddPermissionRequestPermissions.swaggerGeneratedUnknown,
              ''))
      .key;
}

List<String> postAddPermissionRequestPermissionsListToJson(
    List<enums.PostAddPermissionRequestPermissions>?
        postAddPermissionRequestPermissions) {
  if (postAddPermissionRequestPermissions == null) {
    return [];
  }

  return postAddPermissionRequestPermissions
      .map((e) => enums.$PostAddPermissionRequestPermissionsMap[e]!)
      .toList();
}

List<enums.PostAddPermissionRequestPermissions>
    postAddPermissionRequestPermissionsListFromJson(
        List? postAddPermissionRequestPermissions) {
  if (postAddPermissionRequestPermissions == null) {
    return [];
  }

  return postAddPermissionRequestPermissions
      .map((e) => postAddPermissionRequestPermissionsFromJson(e.toString()))
      .toList();
}

String? userDetailsDTORolesToJson(
    enums.UserDetailsDTORoles? userDetailsDTORoles) {
  return enums.$UserDetailsDTORolesMap[userDetailsDTORoles];
}

enums.UserDetailsDTORoles userDetailsDTORolesFromJson(
    String? userDetailsDTORoles) {
  if (userDetailsDTORoles == null) {
    return enums.UserDetailsDTORoles.swaggerGeneratedUnknown;
  }

  return enums.$UserDetailsDTORolesMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == userDetailsDTORoles.toLowerCase(),
          orElse: () => const MapEntry(
              enums.UserDetailsDTORoles.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> userDetailsDTORolesListToJson(
    List<enums.UserDetailsDTORoles>? userDetailsDTORoles) {
  if (userDetailsDTORoles == null) {
    return [];
  }

  return userDetailsDTORoles
      .map((e) => enums.$UserDetailsDTORolesMap[e]!)
      .toList();
}

List<enums.UserDetailsDTORoles> userDetailsDTORolesListFromJson(
    List? userDetailsDTORoles) {
  if (userDetailsDTORoles == null) {
    return [];
  }

  return userDetailsDTORoles
      .map((e) => userDetailsDTORolesFromJson(e.toString()))
      .toList();
}

String? filesystemObjectDTOTypeToJson(
    enums.FilesystemObjectDTOType? filesystemObjectDTOType) {
  return enums.$FilesystemObjectDTOTypeMap[filesystemObjectDTOType];
}

enums.FilesystemObjectDTOType filesystemObjectDTOTypeFromJson(
    String? filesystemObjectDTOType) {
  if (filesystemObjectDTOType == null) {
    return enums.FilesystemObjectDTOType.swaggerGeneratedUnknown;
  }

  return enums.$FilesystemObjectDTOTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              filesystemObjectDTOType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.FilesystemObjectDTOType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> filesystemObjectDTOTypeListToJson(
    List<enums.FilesystemObjectDTOType>? filesystemObjectDTOType) {
  if (filesystemObjectDTOType == null) {
    return [];
  }

  return filesystemObjectDTOType
      .map((e) => enums.$FilesystemObjectDTOTypeMap[e]!)
      .toList();
}

List<enums.FilesystemObjectDTOType> filesystemObjectDTOTypeListFromJson(
    List? filesystemObjectDTOType) {
  if (filesystemObjectDTOType == null) {
    return [];
  }

  return filesystemObjectDTOType
      .map((e) => filesystemObjectDTOTypeFromJson(e.toString()))
      .toList();
}

String? permissionDTOPermissionsToJson(
    enums.PermissionDTOPermissions? permissionDTOPermissions) {
  return enums.$PermissionDTOPermissionsMap[permissionDTOPermissions];
}

enums.PermissionDTOPermissions permissionDTOPermissionsFromJson(
    String? permissionDTOPermissions) {
  if (permissionDTOPermissions == null) {
    return enums.PermissionDTOPermissions.swaggerGeneratedUnknown;
  }

  return enums.$PermissionDTOPermissionsMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              permissionDTOPermissions.toLowerCase(),
          orElse: () => const MapEntry(
              enums.PermissionDTOPermissions.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> permissionDTOPermissionsListToJson(
    List<enums.PermissionDTOPermissions>? permissionDTOPermissions) {
  if (permissionDTOPermissions == null) {
    return [];
  }

  return permissionDTOPermissions
      .map((e) => enums.$PermissionDTOPermissionsMap[e]!)
      .toList();
}

List<enums.PermissionDTOPermissions> permissionDTOPermissionsListFromJson(
    List? permissionDTOPermissions) {
  if (permissionDTOPermissions == null) {
    return [];
  }

  return permissionDTOPermissions
      .map((e) => permissionDTOPermissionsFromJson(e.toString()))
      .toList();
}

String? userFilePermissionsDTOTypesToJson(
    enums.UserFilePermissionsDTOTypes? userFilePermissionsDTOTypes) {
  return enums.$UserFilePermissionsDTOTypesMap[userFilePermissionsDTOTypes];
}

enums.UserFilePermissionsDTOTypes userFilePermissionsDTOTypesFromJson(
    String? userFilePermissionsDTOTypes) {
  if (userFilePermissionsDTOTypes == null) {
    return enums.UserFilePermissionsDTOTypes.swaggerGeneratedUnknown;
  }

  return enums.$UserFilePermissionsDTOTypesMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              userFilePermissionsDTOTypes.toLowerCase(),
          orElse: () => const MapEntry(
              enums.UserFilePermissionsDTOTypes.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> userFilePermissionsDTOTypesListToJson(
    List<enums.UserFilePermissionsDTOTypes>? userFilePermissionsDTOTypes) {
  if (userFilePermissionsDTOTypes == null) {
    return [];
  }

  return userFilePermissionsDTOTypes
      .map((e) => enums.$UserFilePermissionsDTOTypesMap[e]!)
      .toList();
}

List<enums.UserFilePermissionsDTOTypes> userFilePermissionsDTOTypesListFromJson(
    List? userFilePermissionsDTOTypes) {
  if (userFilePermissionsDTOTypes == null) {
    return [];
  }

  return userFilePermissionsDTOTypes
      .map((e) => userFilePermissionsDTOTypesFromJson(e.toString()))
      .toList();
}

String? deleteRoleRequestRolesToJson(
    enums.DeleteRoleRequestRoles? deleteRoleRequestRoles) {
  return enums.$DeleteRoleRequestRolesMap[deleteRoleRequestRoles];
}

enums.DeleteRoleRequestRoles deleteRoleRequestRolesFromJson(
    String? deleteRoleRequestRoles) {
  if (deleteRoleRequestRoles == null) {
    return enums.DeleteRoleRequestRoles.swaggerGeneratedUnknown;
  }

  return enums.$DeleteRoleRequestRolesMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              deleteRoleRequestRoles.toLowerCase(),
          orElse: () => const MapEntry(
              enums.DeleteRoleRequestRoles.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> deleteRoleRequestRolesListToJson(
    List<enums.DeleteRoleRequestRoles>? deleteRoleRequestRoles) {
  if (deleteRoleRequestRoles == null) {
    return [];
  }

  return deleteRoleRequestRoles
      .map((e) => enums.$DeleteRoleRequestRolesMap[e]!)
      .toList();
}

List<enums.DeleteRoleRequestRoles> deleteRoleRequestRolesListFromJson(
    List? deleteRoleRequestRoles) {
  if (deleteRoleRequestRoles == null) {
    return [];
  }

  return deleteRoleRequestRoles
      .map((e) => deleteRoleRequestRolesFromJson(e.toString()))
      .toList();
}

String? deletePermissionsRequestPermissionsToJson(
    enums.DeletePermissionsRequestPermissions?
        deletePermissionsRequestPermissions) {
  return enums.$DeletePermissionsRequestPermissionsMap[
      deletePermissionsRequestPermissions];
}

enums.DeletePermissionsRequestPermissions
    deletePermissionsRequestPermissionsFromJson(
        String? deletePermissionsRequestPermissions) {
  if (deletePermissionsRequestPermissions == null) {
    return enums.DeletePermissionsRequestPermissions.swaggerGeneratedUnknown;
  }

  return enums.$DeletePermissionsRequestPermissionsMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              deletePermissionsRequestPermissions.toLowerCase(),
          orElse: () => const MapEntry(
              enums.DeletePermissionsRequestPermissions.swaggerGeneratedUnknown,
              ''))
      .key;
}

List<String> deletePermissionsRequestPermissionsListToJson(
    List<enums.DeletePermissionsRequestPermissions>?
        deletePermissionsRequestPermissions) {
  if (deletePermissionsRequestPermissions == null) {
    return [];
  }

  return deletePermissionsRequestPermissions
      .map((e) => enums.$DeletePermissionsRequestPermissionsMap[e]!)
      .toList();
}

List<enums.DeletePermissionsRequestPermissions>
    deletePermissionsRequestPermissionsListFromJson(
        List? deletePermissionsRequestPermissions) {
  if (deletePermissionsRequestPermissions == null) {
    return [];
  }

  return deletePermissionsRequestPermissions
      .map((e) => deletePermissionsRequestPermissionsFromJson(e.toString()))
      .toList();
}

@JsonSerializable(explicitToJson: true)
class UserProfileImagePost$RequestBody {
  UserProfileImagePost$RequestBody({
    this.file,
  });

  factory UserProfileImagePost$RequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$UserProfileImagePost$RequestBodyFromJson(json);

  @JsonKey(name: 'file')
  final String? file;
  static const fromJsonFactory = _$UserProfileImagePost$RequestBodyFromJson;
  static const toJsonFactory = _$UserProfileImagePost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserProfileImagePost$RequestBodyToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserProfileImagePost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $UserProfileImagePost$RequestBodyExtension
    on UserProfileImagePost$RequestBody {
  UserProfileImagePost$RequestBody copyWith({String? file}) {
    return UserProfileImagePost$RequestBody(file: file ?? this.file);
  }
}

@JsonSerializable(explicitToJson: true)
class FilesImagePost$RequestBody {
  FilesImagePost$RequestBody({
    this.file,
  });

  factory FilesImagePost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$FilesImagePost$RequestBodyFromJson(json);

  @JsonKey(name: 'file')
  final String? file;
  static const fromJsonFactory = _$FilesImagePost$RequestBodyFromJson;
  static const toJsonFactory = _$FilesImagePost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$FilesImagePost$RequestBodyToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilesImagePost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $FilesImagePost$RequestBodyExtension on FilesImagePost$RequestBody {
  FilesImagePost$RequestBody copyWith({String? file}) {
    return FilesImagePost$RequestBody(file: file ?? this.file);
  }
}

@JsonSerializable(explicitToJson: true)
class FilesFilePost$RequestBody {
  FilesFilePost$RequestBody({
    this.file,
  });

  factory FilesFilePost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$FilesFilePost$RequestBodyFromJson(json);

  @JsonKey(name: 'file')
  final String? file;
  static const fromJsonFactory = _$FilesFilePost$RequestBodyFromJson;
  static const toJsonFactory = _$FilesFilePost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$FilesFilePost$RequestBodyToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilesFilePost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $FilesFilePost$RequestBodyExtension on FilesFilePost$RequestBody {
  FilesFilePost$RequestBody copyWith({String? file}) {
    return FilesFilePost$RequestBody(file: file ?? this.file);
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(ApiJsonDecoderMappings);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
