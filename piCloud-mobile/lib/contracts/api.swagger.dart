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

  ///Creates user with given values
  ///@param user JSON object of users registration data
  @Post(path: '/user/new')
  Future<chopper.Response> userNewPost(
      {@Body() required PostUserRequest? body});

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

  ///STABILITY: In early development
  ///@param imageName
  @Post(path: '/files/image/{imageName}')
  Future<chopper.Response<FileInfoDTO>> filesImageImageNamePost(
      {@Path('imageName') required String? imageName,
      @Body() required FilesImageImageNamePost$RequestBody? body});

  ///STABILITY: Usually very basic hand testing
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

  ///STABILITY: Usually very basic hand testing
  ///@param fileType
  ///@param filepath
  @Post(path: '/files/file')
  Future<chopper.Response<FileInfoDTO>> _filesFilePost(
      {@Query('fileType') String? fileType,
      @Query('filepath') required String? filepath,
      @Body() required FilesFilePost$RequestBody? body});

  ///STABILITY: In early development
  @Delete(path: '/files/file')
  Future<chopper.Response> filesFileDelete();

  ///
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

  ///moves file
  @Patch(path: '/filesystem/move')
  Future<chopper.Response> filesystemMovePatch(
      {@Body() required MoveFileRequest? body});

  ///returns all details of user with provided username
  ///@param usernames One or more usernames whose details you want to acquire
  @Get(path: '/user/{usernames}/details')
  Future<chopper.Response<List<UserDetailsDTO>>> userUsernamesDetailsGet(
      {@Path('usernames') required List<String>? usernames});

  ///Returns all users
  @Get(path: '/user/')
  Future<chopper.Response<List<UserIdDTO>>> userGet();

  ///retrieves information about requested file
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
      @Query('fileStructureRoot') String? fileStructureRoot});

  ///STABILITY: In early development
  ///@param previewResolution
  ///@param imageIds
  @Get(path: '/files/image-preview')
  Future<chopper.Response> filesImagePreviewGet(
      {@Query('previewResolution') int? previewResolution,
      @Query('imageIds') required List<String>? imageIds});

  ///STABILITY: In early development
  ///@param fileId
  @Get(path: '/files/file/{fileId}')
  Future<chopper.Response<String>> filesFileFileIdGet(
      {@Path('fileId') required String? fileId});

  ///STABILITY: In early development
  ///@param fileId
  @Delete(path: '/files/file/{fileId}')
  Future<chopper.Response> filesFileFileIdDelete(
      {@Path('fileId') required String? fileId});

  ///Not implemented
  ///@param directoryId
  @Get(path: '/files/directory/{directoryId}')
  Future<chopper.Response<String>> filesDirectoryDirectoryIdGet(
      {@Path('directoryId') required String? directoryId});

  ///
  @Get(path: '/drive')
  Future<chopper.Response<List<DriveDTO>>> driveGet();

  ///
  @Get(path: '/drive/discs')
  Future<chopper.Response<List<DiscDTO>>> driveDiscsGet();

  ///deletes directory with provided id
  ///@param directoryId
  @Delete(path: '/filesystem/directory/{directoryId}')
  Future<chopper.Response> filesystemDirectoryDirectoryIdDelete(
      {@Path('directoryId') required String? directoryId});
}

final Map<Type, Object Function(Map<String, dynamic>)> ApiJsonDecoderMappings =
    {
  ErrorBody: ErrorBody.fromJsonFactory,
  FileInfoDTO: FileInfoDTO.fromJsonFactory,
  PostUserRequest: PostUserRequest.fromJsonFactory,
  LoginRequest: LoginRequest.fromJsonFactory,
  PostDriveRequest: PostDriveRequest.fromJsonFactory,
  DriveDTO: DriveDTO.fromJsonFactory,
  PatchUserRequest: PatchUserRequest.fromJsonFactory,
  MoveFileRequest: MoveFileRequest.fromJsonFactory,
  UserDetailsDTO: UserDetailsDTO.fromJsonFactory,
  UserIdDTO: UserIdDTO.fromJsonFactory,
  FilesystemInfoDTO: FilesystemInfoDTO.fromJsonFactory,
  FileStructureDTO: FileStructureDTO.fromJsonFactory,
  FilesystemObjectDTO: FilesystemObjectDTO.fromJsonFactory,
  DiscDTO: DiscDTO.fromJsonFactory,
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
    this.parentUUID,
    this.hasThumbnail,
    this.type,
    this.size,
    this.modifiedAt,
    this.createdAt,
  });

  factory FileInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$FileInfoDTOFromJson(json);

  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'parentUUID')
  final String? parentUUID;
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
            (identical(other.parentUUID, parentUUID) ||
                const DeepCollectionEquality()
                    .equals(other.parentUUID, parentUUID)) &&
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
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(parentUUID) ^
      const DeepCollectionEquality().hash(hasThumbnail) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $FileInfoDTOExtension on FileInfoDTO {
  FileInfoDTO copyWith(
      {String? pubId,
      String? name,
      String? path,
      String? parentUUID,
      bool? hasThumbnail,
      enums.FileInfoDTOType? type,
      int? size,
      DateTime? modifiedAt,
      DateTime? createdAt}) {
    return FileInfoDTO(
        pubId: pubId ?? this.pubId,
        name: name ?? this.name,
        path: path ?? this.path,
        parentUUID: parentUUID ?? this.parentUUID,
        hasThumbnail: hasThumbnail ?? this.hasThumbnail,
        type: type ?? this.type,
        size: size ?? this.size,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdAt: createdAt ?? this.createdAt);
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
    this.pathToProfilePicture,
  });

  factory PatchUserRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchUserRequestFromJson(json);

  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'pathToProfilePicture')
  final String? pathToProfilePicture;
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
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.pathToProfilePicture, pathToProfilePicture) ||
                const DeepCollectionEquality()
                    .equals(other.pathToProfilePicture, pathToProfilePicture)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(pathToProfilePicture) ^
      runtimeType.hashCode;
}

extension $PatchUserRequestExtension on PatchUserRequest {
  PatchUserRequest copyWith(
      {String? nickname, String? email, String? pathToProfilePicture}) {
    return PatchUserRequest(
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        pathToProfilePicture:
            pathToProfilePicture ?? this.pathToProfilePicture);
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
    this.pathToProfilePicture,
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
  @JsonKey(name: 'pathToProfilePicture')
  final String? pathToProfilePicture;
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
            (identical(other.pathToProfilePicture, pathToProfilePicture) ||
                const DeepCollectionEquality().equals(
                    other.pathToProfilePicture, pathToProfilePicture)) &&
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
      const DeepCollectionEquality().hash(pathToProfilePicture) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(roles) ^
      runtimeType.hashCode;
}

extension $UserDetailsDTOExtension on UserDetailsDTO {
  UserDetailsDTO copyWith(
      {String? username,
      String? email,
      String? pathToProfilePicture,
      String? nickname,
      String? pubId,
      List<enums.UserDetailsDTORoles>? roles}) {
    return UserDetailsDTO(
        username: username ?? this.username,
        email: email ?? this.email,
        pathToProfilePicture: pathToProfilePicture ?? this.pathToProfilePicture,
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
    this.pathToProfilePicture,
  });

  factory UserIdDTO.fromJson(Map<String, dynamic> json) =>
      _$UserIdDTOFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'pathToProfilePicture')
  final String? pathToProfilePicture;
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
            (identical(other.pathToProfilePicture, pathToProfilePicture) ||
                const DeepCollectionEquality()
                    .equals(other.pathToProfilePicture, pathToProfilePicture)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(pathToProfilePicture) ^
      runtimeType.hashCode;
}

extension $UserIdDTOExtension on UserIdDTO {
  UserIdDTO copyWith(
      {String? username,
      String? pubId,
      String? nickname,
      String? pathToProfilePicture}) {
    return UserIdDTO(
        username: username ?? this.username,
        pubId: pubId ?? this.pubId,
        nickname: nickname ?? this.nickname,
        pathToProfilePicture:
            pathToProfilePicture ?? this.pathToProfilePicture);
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
    this.version,
    this.children,
  });

  factory FilesystemObjectDTO.fromJson(Map<String, dynamic> json) =>
      _$FilesystemObjectDTOFromJson(json);

  @JsonKey(name: 'pubId')
  final String? pubId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'version')
  final int? version;
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
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.children, children) ||
                const DeepCollectionEquality()
                    .equals(other.children, children)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pubId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(children) ^
      runtimeType.hashCode;
}

extension $FilesystemObjectDTOExtension on FilesystemObjectDTO {
  FilesystemObjectDTO copyWith(
      {String? pubId,
      String? name,
      int? version,
      List<FilesystemObjectDTO>? children}) {
    return FilesystemObjectDTO(
        pubId: pubId ?? this.pubId,
        name: name ?? this.name,
        version: version ?? this.version,
        children: children ?? this.children);
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

@JsonSerializable(explicitToJson: true)
class FilesImageImageNamePost$RequestBody {
  FilesImageImageNamePost$RequestBody({
    this.file,
  });

  factory FilesImageImageNamePost$RequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$FilesImageImageNamePost$RequestBodyFromJson(json);

  @JsonKey(name: 'file')
  final String? file;
  static const fromJsonFactory = _$FilesImageImageNamePost$RequestBodyFromJson;
  static const toJsonFactory = _$FilesImageImageNamePost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$FilesImageImageNamePost$RequestBodyToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilesImageImageNamePost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $FilesImageImageNamePost$RequestBodyExtension
    on FilesImageImageNamePost$RequestBody {
  FilesImageImageNamePost$RequestBody copyWith({String? file}) {
    return FilesImageImageNamePost$RequestBody(file: file ?? this.file);
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
