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

  ///Forces file upload
  ///@param fileType
  ///@param filepath
  ///@param file
  Future<chopper.Response> filesFilePut(
      {required enums.FilesFilePutFileType? fileType,
      required String? filepath,
      required String? file}) {
    return _filesFilePut(
        fileType: enums.$FilesFilePutFileTypeMap[fileType],
        filepath: filepath,
        file: file);
  }

  ///Forces file upload
  ///@param fileType
  ///@param filepath
  ///@param file
  @Put(path: '/files/file', optionalBody: true)
  Future<chopper.Response> _filesFilePut(
      {@Query('fileType') required String? fileType,
      @Query('filepath') required String? filepath,
      @Query('file') required String? file});

  ///Uploads file
  ///@param fileType
  ///@param file
  Future<chopper.Response> filesFilePost(
      {required enums.FilesFilePostFileType? fileType,
      required String? file,
      required String? body}) {
    return _filesFilePost(
        fileType: enums.$FilesFilePostFileTypeMap[fileType],
        file: file,
        body: body);
  }

  ///Uploads file
  ///@param fileType
  ///@param file
  @Post(path: '/files/file')
  Future<chopper.Response> _filesFilePost(
      {@Query('fileType') required String? fileType,
      @Query('file') required String? file,
      @Body() required String? body});

  ///
  @Post(path: '/user-management/')
  Future<chopper.Response> userManagementPost(
      {@Body() required PostUserRequest? body});

  ///
  @Post(path: '/refresh/refresh', optionalBody: true)
  Future<chopper.Response> refreshRefreshPost();

  ///
  @Post(path: '/refresh/auth', optionalBody: true)
  Future<chopper.Response> refreshAuthPost();

  ///
  @Post(path: '/login')
  Future<chopper.Response> loginPost({@Body() required LoginRequest? body});

  ///
  ///@param newAssignedSpace
  @Post(path: '/filesystem/users-drives/{username}', optionalBody: true)
  Future<chopper.Response> filesystemUsersDrivesUsernamePost(
      {@Query('newAssignedSpace') required int? newAssignedSpace});

  ///Image uploads
  ///@param imageName Name with extension of image to upload
  ///@param image
  @Post(path: '/files/image/{imageName}', optionalBody: true)
  Future<chopper.Response> filesImageImageNamePost(
      {@Query('imageName') required String? imageName,
      @Query('image') required List<String>? image});

  ///Creates empty directory
  @Post(path: '/files/directory')
  Future<chopper.Response> filesDirectoryPost({@Body() required String? body});

  ///
  ///@param discId
  @Post(path: '/discs/{discId}/unmount', optionalBody: true)
  Future<chopper.Response> discsDiscIdUnmountPost(
      {@Query('discId') required int? discId});

  ///
  ///@param discId
  @Post(path: '/discs/{discId}/mount', optionalBody: true)
  Future<chopper.Response> discsDiscIdMountPost(
      {@Query('discId') required int? discId});

  ///
  @Post(path: '/authorities/{userId}', optionalBody: true)
  Future<chopper.Response> authoritiesUserIdPost();

  ///
  ///@param username
  @Get(path: '/user-management/{username}')
  Future<chopper.Response<GetUserWithDetailsResponse>>
      userManagementUsernameGet({@Path('username') required String? username});

  ///
  ///@param username
  @Delete(path: '/user-management/{username}')
  Future<chopper.Response> userManagementUsernameDelete(
      {@Path('username') required String? username});

  ///
  ///@param username
  @Patch(path: '/user-management/{username}')
  Future<chopper.Response> userManagementUsernamePatch(
      {@Query('username') required String? username,
      @Body() required UpdateUserDetailsRequest? body});

  ///
  @Get(path: '/user-management/get-all')
  Future<chopper.Response<List<GetUserResponse>>> userManagementGetAllGet();

  ///
  @Get(path: '/user-management/get-all/with-details')
  Future<chopper.Response<List<GetUserWithDetailsResponse>>>
      userManagementGetAllWithDetailsGet();

  ///
  @Get(path: '/filesystem/users-drives')
  Future<chopper.Response<List<GetUserDriveInfo>>> filesystemUsersDrivesGet();

  ///
  ///@param username
  ///@param structureLevels
  ///@param fileStructureRoot
  @Get(path: '/filesystem/user/{username}')
  Future<chopper.Response<FileStructureDTO>> filesystemUserUsernameGet(
      {@Path('username') required String? username,
      @Query('structureLevels') int? structureLevels,
      @Query('fileStructureRoot') String? fileStructureRoot});

  ///
  ///@param fileId
  ///@param with-permissions
  @Get(path: '/filesystem/info/{fileId}')
  Future<chopper.Response<FileDto>> filesystemInfoFileIdGet(
      {@Path('fileId') required int? fileId,
      @Path('with-permissions') required bool? withPermissions});

  ///
  @Get(path: '/files/{fileId}')
  Future<chopper.Response<GetFilePermissionsResponse>> filesFileIdGet();

  ///returns requested images in reduced resolution
  ///@param previewResolution
  ///@param imageFormat
  ///@param imageNames
  @Get(path: '/files/image-preview')
  Future<chopper.Response> filesImagePreviewGet(
      {@Query('previewResolution') required int? previewResolution,
      @Query('imageFormat') required String? imageFormat,
      @Query('imageNames') required List<String>? imageNames});

  ///Downloads file
  ///@param fileId
  @Get(path: '/files/file/{fileId}')
  Future<chopper.Response<String>> filesFileFileIdGet(
      {@Query('fileId') required String? fileId});

  ///override standard description
  @Delete(path: '/files/file/{fileId}')
  Future<chopper.Response> filesFileFileIdDelete(
      {@Body() required String? body});

  ///Compresses directory and downloads it
  ///@param directoryId
  @Get(path: '/files/directory/{directoryId}')
  Future<chopper.Response<String>> filesDirectoryDirectoryIdGet(
      {@Query('directoryId') required String? directoryId});

  ///deletes empty directory
  @Delete(path: '/files/directory/{directoryId}')
  Future<chopper.Response> filesDirectoryDirectoryIdDelete(
      {@Body() required String? body});

  ///
  ///@param fileId
  @Get(path: '/files/')
  Future<chopper.Response<List<GetFilePermissionsResponse>>> filesGet(
      {@Query('fileId') required List<int>? fileId});

  ///
  @Get(path: '/discs')
  Future<chopper.Response<List<DiscInfo>>> discsGet();

  ///
  ///@param discId
  @Get(path: '/discs/{discId}')
  Future<chopper.Response<DiscDetails>> discsDiscIdGet(
      {@Query('discId') required int? discId});

  ///
  ///@param driveId
  @Get(path: '/discs/drive/{driveId}')
  Future<chopper.Response<List<DiscInfo>>> discsDriveDriveIdGet(
      {@Query('driveId') required String? driveId});

  ///
  @Get(path: '/authorities/{username}/canBeGiven')
  Future<chopper.Response<GetAuthoritiesInfoResponse>>
      authoritiesUsernameCanBeGivenGet();

  ///
  ///@param username
  @Get(path: '/authorities/{login}')
  Future<chopper.Response> authoritiesLoginGet(
      {@Query('username') required String? username});

  ///
  ///@param username
  @Delete(path: '/user-management/{username}/delete-now')
  Future<chopper.Response> userManagementUsernameDeleteNowDelete(
      {@Path('username') required String? username});

  ///forces to delete directory
  @Delete(path: '/files/directory/{directoryId}/force')
  Future<chopper.Response> filesDirectoryDirectoryIdForceDelete(
      {@Body() required String? body});
}

final Map<Type, Object Function(Map<String, dynamic>)> ApiJsonDecoderMappings =
    {
  PostUserRequest: PostUserRequest.fromJsonFactory,
  LoginRequest: LoginRequest.fromJsonFactory,
  UpdateUserDetailsRequest: UpdateUserDetailsRequest.fromJsonFactory,
  GetUserWithDetailsResponse: GetUserWithDetailsResponse.fromJsonFactory,
  GetUserResponse: GetUserResponse.fromJsonFactory,
  GetUserDriveInfo: GetUserDriveInfo.fromJsonFactory,
  DirectoryInfoDto: DirectoryInfoDto.fromJsonFactory,
  FSDirectoryDTO: FSDirectoryDTO.fromJsonFactory,
  FSFileDTO: FSFileDTO.fromJsonFactory,
  FileInfoDto: FileInfoDto.fromJsonFactory,
  FileStructureDTO: FileStructureDTO.fromJsonFactory,
  FileDto: FileDto.fromJsonFactory,
  GetFilePermissionsResponse: GetFilePermissionsResponse.fromJsonFactory,
  UserFilePermissions: UserFilePermissions.fromJsonFactory,
  DiscInfo: DiscInfo.fromJsonFactory,
  DiscDetails: DiscDetails.fromJsonFactory,
  DriveDTO: DriveDTO.fromJsonFactory,
  GetAuthoritiesInfoResponse: GetAuthoritiesInfoResponse.fromJsonFactory,
  RoleInfo: RoleInfo.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class PostUserRequest {
  PostUserRequest({
    this.login,
    this.username,
    this.password,
    this.accountType,
    this.email,
  });

  factory PostUserRequest.fromJson(Map<String, dynamic> json) =>
      _$PostUserRequestFromJson(json);

  @JsonKey(name: 'login')
  final String? login;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(
      name: 'accountType',
      toJson: postUserRequestAccountTypeToJson,
      fromJson: postUserRequestAccountTypeFromJson)
  final enums.PostUserRequestAccountType? accountType;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$PostUserRequestFromJson;
  static const toJsonFactory = _$PostUserRequestToJson;
  Map<String, dynamic> toJson() => _$PostUserRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostUserRequest &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $PostUserRequestExtension on PostUserRequest {
  PostUserRequest copyWith(
      {String? login,
      String? username,
      String? password,
      enums.PostUserRequestAccountType? accountType,
      String? email}) {
    return PostUserRequest(
        login: login ?? this.login,
        username: username ?? this.username,
        password: password ?? this.password,
        accountType: accountType ?? this.accountType,
        email: email ?? this.email);
  }
}

@JsonSerializable(explicitToJson: true)
class LoginRequest {
  LoginRequest({
    this.login,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  @JsonKey(name: 'login')
  final String? login;
  @JsonKey(name: 'password')
  final String? password;
  static const fromJsonFactory = _$LoginRequestFromJson;
  static const toJsonFactory = _$LoginRequestToJson;
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginRequest &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $LoginRequestExtension on LoginRequest {
  LoginRequest copyWith({String? login, String? password}) {
    return LoginRequest(
        login: login ?? this.login, password: password ?? this.password);
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserDetailsRequest {
  UpdateUserDetailsRequest({
    this.username,
    this.email,
    this.pathToProfilePicture,
  });

  factory UpdateUserDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDetailsRequestFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'pathToProfilePicture')
  final String? pathToProfilePicture;
  static const fromJsonFactory = _$UpdateUserDetailsRequestFromJson;
  static const toJsonFactory = _$UpdateUserDetailsRequestToJson;
  Map<String, dynamic> toJson() => _$UpdateUserDetailsRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateUserDetailsRequest &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.pathToProfilePicture, pathToProfilePicture) ||
                const DeepCollectionEquality()
                    .equals(other.pathToProfilePicture, pathToProfilePicture)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(pathToProfilePicture) ^
      runtimeType.hashCode;
}

extension $UpdateUserDetailsRequestExtension on UpdateUserDetailsRequest {
  UpdateUserDetailsRequest copyWith(
      {String? username, String? email, String? pathToProfilePicture}) {
    return UpdateUserDetailsRequest(
        username: username ?? this.username,
        email: email ?? this.email,
        pathToProfilePicture:
            pathToProfilePicture ?? this.pathToProfilePicture);
  }
}

@JsonSerializable(explicitToJson: true)
class GetUserWithDetailsResponse {
  GetUserWithDetailsResponse({
    this.username,
    this.email,
    this.isLocked,
    this.accountType,
    this.usersPermissions,
    this.usersRoles,
  });

  factory GetUserWithDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserWithDetailsResponseFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'isLocked')
  final bool? isLocked;
  @JsonKey(
      name: 'accountType',
      toJson: getUserWithDetailsResponseAccountTypeToJson,
      fromJson: getUserWithDetailsResponseAccountTypeFromJson)
  final enums.GetUserWithDetailsResponseAccountType? accountType;
  @JsonKey(name: 'usersPermissions', defaultValue: <String>[])
  final List<String>? usersPermissions;
  @JsonKey(name: 'usersRoles', defaultValue: <String>[])
  final List<String>? usersRoles;
  static const fromJsonFactory = _$GetUserWithDetailsResponseFromJson;
  static const toJsonFactory = _$GetUserWithDetailsResponseToJson;
  Map<String, dynamic> toJson() => _$GetUserWithDetailsResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserWithDetailsResponse &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.isLocked, isLocked) ||
                const DeepCollectionEquality()
                    .equals(other.isLocked, isLocked)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)) &&
            (identical(other.usersPermissions, usersPermissions) ||
                const DeepCollectionEquality()
                    .equals(other.usersPermissions, usersPermissions)) &&
            (identical(other.usersRoles, usersRoles) ||
                const DeepCollectionEquality()
                    .equals(other.usersRoles, usersRoles)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(isLocked) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(usersPermissions) ^
      const DeepCollectionEquality().hash(usersRoles) ^
      runtimeType.hashCode;
}

extension $GetUserWithDetailsResponseExtension on GetUserWithDetailsResponse {
  GetUserWithDetailsResponse copyWith(
      {String? username,
      String? email,
      bool? isLocked,
      enums.GetUserWithDetailsResponseAccountType? accountType,
      List<String>? usersPermissions,
      List<String>? usersRoles}) {
    return GetUserWithDetailsResponse(
        username: username ?? this.username,
        email: email ?? this.email,
        isLocked: isLocked ?? this.isLocked,
        accountType: accountType ?? this.accountType,
        usersPermissions: usersPermissions ?? this.usersPermissions,
        usersRoles: usersRoles ?? this.usersRoles);
  }
}

@JsonSerializable(explicitToJson: true)
class GetUserResponse {
  GetUserResponse({
    this.username,
    this.pathToProfilePicture,
    this.accountType,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'pathToProfilePicture')
  final String? pathToProfilePicture;
  @JsonKey(
      name: 'accountType',
      toJson: getUserResponseAccountTypeToJson,
      fromJson: getUserResponseAccountTypeFromJson)
  final enums.GetUserResponseAccountType? accountType;
  static const fromJsonFactory = _$GetUserResponseFromJson;
  static const toJsonFactory = _$GetUserResponseToJson;
  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserResponse &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.pathToProfilePicture, pathToProfilePicture) ||
                const DeepCollectionEquality().equals(
                    other.pathToProfilePicture, pathToProfilePicture)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(pathToProfilePicture) ^
      const DeepCollectionEquality().hash(accountType) ^
      runtimeType.hashCode;
}

extension $GetUserResponseExtension on GetUserResponse {
  GetUserResponse copyWith(
      {String? username,
      String? pathToProfilePicture,
      enums.GetUserResponseAccountType? accountType}) {
    return GetUserResponse(
        username: username ?? this.username,
        pathToProfilePicture: pathToProfilePicture ?? this.pathToProfilePicture,
        accountType: accountType ?? this.accountType);
  }
}

@JsonSerializable(explicitToJson: true)
class GetUserDriveInfo {
  GetUserDriveInfo({
    this.username,
    this.assignedSpace,
    this.usedSpace,
  });

  factory GetUserDriveInfo.fromJson(Map<String, dynamic> json) =>
      _$GetUserDriveInfoFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'assignedSpace')
  final int? assignedSpace;
  @JsonKey(name: 'usedSpace')
  final int? usedSpace;
  static const fromJsonFactory = _$GetUserDriveInfoFromJson;
  static const toJsonFactory = _$GetUserDriveInfoToJson;
  Map<String, dynamic> toJson() => _$GetUserDriveInfoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserDriveInfo &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.assignedSpace, assignedSpace) ||
                const DeepCollectionEquality()
                    .equals(other.assignedSpace, assignedSpace)) &&
            (identical(other.usedSpace, usedSpace) ||
                const DeepCollectionEquality()
                    .equals(other.usedSpace, usedSpace)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(assignedSpace) ^
      const DeepCollectionEquality().hash(usedSpace) ^
      runtimeType.hashCode;
}

extension $GetUserDriveInfoExtension on GetUserDriveInfo {
  GetUserDriveInfo copyWith(
      {String? username, int? assignedSpace, int? usedSpace}) {
    return GetUserDriveInfo(
        username: username ?? this.username,
        assignedSpace: assignedSpace ?? this.assignedSpace,
        usedSpace: usedSpace ?? this.usedSpace);
  }
}

@JsonSerializable(explicitToJson: true)
class DirectoryInfoDto {
  DirectoryInfoDto({
    this.name,
    this.size,
    this.modifiedAt,
    this.createdAt,
    this.id,
  });

  factory DirectoryInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DirectoryInfoDtoFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'modifiedAt')
  final DateTime? modifiedAt;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'id')
  final String? id;
  static const fromJsonFactory = _$DirectoryInfoDtoFromJson;
  static const toJsonFactory = _$DirectoryInfoDtoToJson;
  Map<String, dynamic> toJson() => _$DirectoryInfoDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DirectoryInfoDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.modifiedAt, modifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.modifiedAt, modifiedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $DirectoryInfoDtoExtension on DirectoryInfoDto {
  DirectoryInfoDto copyWith(
      {String? name,
      int? size,
      DateTime? modifiedAt,
      DateTime? createdAt,
      String? id}) {
    return DirectoryInfoDto(
        name: name ?? this.name,
        size: size ?? this.size,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id);
  }
}

@JsonSerializable(explicitToJson: true)
class FSDirectoryDTO {
  FSDirectoryDTO({
    this.id,
    this.details,
    this.files,
    this.directories,
  });

  factory FSDirectoryDTO.fromJson(Map<String, dynamic> json) =>
      _$FSDirectoryDTOFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'details')
  final DirectoryInfoDto? details;
  @JsonKey(name: 'files', defaultValue: <FSFileDTO>[])
  final List<FSFileDTO>? files;
  @JsonKey(name: 'directories', defaultValue: <FSDirectoryDTO>[])
  final List<FSDirectoryDTO>? directories;
  static const fromJsonFactory = _$FSDirectoryDTOFromJson;
  static const toJsonFactory = _$FSDirectoryDTOToJson;
  Map<String, dynamic> toJson() => _$FSDirectoryDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FSDirectoryDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.details, details) ||
                const DeepCollectionEquality()
                    .equals(other.details, details)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.directories, directories) ||
                const DeepCollectionEquality()
                    .equals(other.directories, directories)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(details) ^
      const DeepCollectionEquality().hash(files) ^
      const DeepCollectionEquality().hash(directories) ^
      runtimeType.hashCode;
}

extension $FSDirectoryDTOExtension on FSDirectoryDTO {
  FSDirectoryDTO copyWith(
      {String? id,
      DirectoryInfoDto? details,
      List<FSFileDTO>? files,
      List<FSDirectoryDTO>? directories}) {
    return FSDirectoryDTO(
        id: id ?? this.id,
        details: details ?? this.details,
        files: files ?? this.files,
        directories: directories ?? this.directories);
  }
}

@JsonSerializable(explicitToJson: true)
class FSFileDTO {
  FSFileDTO({
    this.id,
    this.details,
  });

  factory FSFileDTO.fromJson(Map<String, dynamic> json) =>
      _$FSFileDTOFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'details')
  final FileInfoDto? details;
  static const fromJsonFactory = _$FSFileDTOFromJson;
  static const toJsonFactory = _$FSFileDTOToJson;
  Map<String, dynamic> toJson() => _$FSFileDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FSFileDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.details, details) ||
                const DeepCollectionEquality().equals(other.details, details)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(details) ^
      runtimeType.hashCode;
}

extension $FSFileDTOExtension on FSFileDTO {
  FSFileDTO copyWith({String? id, FileInfoDto? details}) {
    return FSFileDTO(id: id ?? this.id, details: details ?? this.details);
  }
}

@JsonSerializable(explicitToJson: true)
class FileInfoDto {
  FileInfoDto({
    this.id,
    this.name,
    this.size,
    this.modifiedAt,
    this.createdAt,
    this.fileType,
    this.hasThumbnail,
  });

  factory FileInfoDto.fromJson(Map<String, dynamic> json) =>
      _$FileInfoDtoFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'modifiedAt')
  final DateTime? modifiedAt;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(
      name: 'fileType',
      toJson: fileInfoDtoFileTypeToJson,
      fromJson: fileInfoDtoFileTypeFromJson)
  final enums.FileInfoDtoFileType? fileType;
  @JsonKey(name: 'hasThumbnail')
  final bool? hasThumbnail;
  static const fromJsonFactory = _$FileInfoDtoFromJson;
  static const toJsonFactory = _$FileInfoDtoToJson;
  Map<String, dynamic> toJson() => _$FileInfoDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileInfoDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.modifiedAt, modifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.modifiedAt, modifiedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)) &&
            (identical(other.hasThumbnail, hasThumbnail) ||
                const DeepCollectionEquality()
                    .equals(other.hasThumbnail, hasThumbnail)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(fileType) ^
      const DeepCollectionEquality().hash(hasThumbnail) ^
      runtimeType.hashCode;
}

extension $FileInfoDtoExtension on FileInfoDto {
  FileInfoDto copyWith(
      {String? id,
      String? name,
      int? size,
      DateTime? modifiedAt,
      DateTime? createdAt,
      enums.FileInfoDtoFileType? fileType,
      bool? hasThumbnail}) {
    return FileInfoDto(
        id: id ?? this.id,
        name: name ?? this.name,
        size: size ?? this.size,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdAt: createdAt ?? this.createdAt,
        fileType: fileType ?? this.fileType,
        hasThumbnail: hasThumbnail ?? this.hasThumbnail);
  }
}

@JsonSerializable(explicitToJson: true)
class FileStructureDTO {
  FileStructureDTO({
    this.depth,
    this.rootDirectoryPath,
    this.rootDirectory,
  });

  factory FileStructureDTO.fromJson(Map<String, dynamic> json) =>
      _$FileStructureDTOFromJson(json);

  @JsonKey(name: 'depth')
  final int? depth;
  @JsonKey(name: 'rootDirectoryPath')
  final String? rootDirectoryPath;
  @JsonKey(name: 'rootDirectory')
  final FSDirectoryDTO? rootDirectory;
  static const fromJsonFactory = _$FileStructureDTOFromJson;
  static const toJsonFactory = _$FileStructureDTOToJson;
  Map<String, dynamic> toJson() => _$FileStructureDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileStructureDTO &&
            (identical(other.depth, depth) ||
                const DeepCollectionEquality().equals(other.depth, depth)) &&
            (identical(other.rootDirectoryPath, rootDirectoryPath) ||
                const DeepCollectionEquality()
                    .equals(other.rootDirectoryPath, rootDirectoryPath)) &&
            (identical(other.rootDirectory, rootDirectory) ||
                const DeepCollectionEquality()
                    .equals(other.rootDirectory, rootDirectory)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(depth) ^
      const DeepCollectionEquality().hash(rootDirectoryPath) ^
      const DeepCollectionEquality().hash(rootDirectory) ^
      runtimeType.hashCode;
}

extension $FileStructureDTOExtension on FileStructureDTO {
  FileStructureDTO copyWith(
      {int? depth, String? rootDirectoryPath, FSDirectoryDTO? rootDirectory}) {
    return FileStructureDTO(
        depth: depth ?? this.depth,
        rootDirectoryPath: rootDirectoryPath ?? this.rootDirectoryPath,
        rootDirectory: rootDirectory ?? this.rootDirectory);
  }
}

@JsonSerializable(explicitToJson: true)
class FileDto {
  FileDto({
    this.id,
    this.parentId,
    this.driveId,
    this.fileName,
    this.fileType,
    this.path,
    this.size,
    this.createdAt,
    this.modifiedAt,
  });

  factory FileDto.fromJson(Map<String, dynamic> json) =>
      _$FileDtoFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'parentId')
  final String? parentId;
  @JsonKey(name: 'driveId')
  final int? driveId;
  @JsonKey(name: 'fileName')
  final String? fileName;
  @JsonKey(
      name: 'fileType',
      toJson: fileDtoFileTypeToJson,
      fromJson: fileDtoFileTypeFromJson)
  final enums.FileDtoFileType? fileType;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'modifiedAt')
  final DateTime? modifiedAt;
  static const fromJsonFactory = _$FileDtoFromJson;
  static const toJsonFactory = _$FileDtoToJson;
  Map<String, dynamic> toJson() => _$FileDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.parentId, parentId) ||
                const DeepCollectionEquality()
                    .equals(other.parentId, parentId)) &&
            (identical(other.driveId, driveId) ||
                const DeepCollectionEquality()
                    .equals(other.driveId, driveId)) &&
            (identical(other.fileName, fileName) ||
                const DeepCollectionEquality()
                    .equals(other.fileName, fileName)) &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.modifiedAt, modifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.modifiedAt, modifiedAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(parentId) ^
      const DeepCollectionEquality().hash(driveId) ^
      const DeepCollectionEquality().hash(fileName) ^
      const DeepCollectionEquality().hash(fileType) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(modifiedAt) ^
      runtimeType.hashCode;
}

extension $FileDtoExtension on FileDto {
  FileDto copyWith(
      {String? id,
      String? parentId,
      int? driveId,
      String? fileName,
      enums.FileDtoFileType? fileType,
      String? path,
      int? size,
      DateTime? createdAt,
      DateTime? modifiedAt}) {
    return FileDto(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        driveId: driveId ?? this.driveId,
        fileName: fileName ?? this.fileName,
        fileType: fileType ?? this.fileType,
        path: path ?? this.path,
        size: size ?? this.size,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt);
  }
}

@JsonSerializable(explicitToJson: true)
class GetFilePermissionsResponse {
  GetFilePermissionsResponse({
    this.discObjectId,
    this.permissions,
  });

  factory GetFilePermissionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFilePermissionsResponseFromJson(json);

  @JsonKey(name: 'discObjectId')
  final int? discObjectId;
  @JsonKey(name: 'permissions', defaultValue: <UserFilePermissions>[])
  final List<UserFilePermissions>? permissions;
  static const fromJsonFactory = _$GetFilePermissionsResponseFromJson;
  static const toJsonFactory = _$GetFilePermissionsResponseToJson;
  Map<String, dynamic> toJson() => _$GetFilePermissionsResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetFilePermissionsResponse &&
            (identical(other.discObjectId, discObjectId) ||
                const DeepCollectionEquality()
                    .equals(other.discObjectId, discObjectId)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(discObjectId) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $GetFilePermissionsResponseExtension on GetFilePermissionsResponse {
  GetFilePermissionsResponse copyWith(
      {int? discObjectId, List<UserFilePermissions>? permissions}) {
    return GetFilePermissionsResponse(
        discObjectId: discObjectId ?? this.discObjectId,
        permissions: permissions ?? this.permissions);
  }
}

@JsonSerializable(explicitToJson: true)
class UserFilePermissions {
  UserFilePermissions({
    this.username,
    this.usersPermissions,
  });

  factory UserFilePermissions.fromJson(Map<String, dynamic> json) =>
      _$UserFilePermissionsFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(
      name: 'usersPermissions',
      toJson: userFilePermissionsUsersPermissionsListToJson,
      fromJson: userFilePermissionsUsersPermissionsListFromJson)
  final List<enums.UserFilePermissionsUsersPermissions>? usersPermissions;
  static const fromJsonFactory = _$UserFilePermissionsFromJson;
  static const toJsonFactory = _$UserFilePermissionsToJson;
  Map<String, dynamic> toJson() => _$UserFilePermissionsToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserFilePermissions &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.usersPermissions, usersPermissions) ||
                const DeepCollectionEquality()
                    .equals(other.usersPermissions, usersPermissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(usersPermissions) ^
      runtimeType.hashCode;
}

extension $UserFilePermissionsExtension on UserFilePermissions {
  UserFilePermissions copyWith(
      {String? username,
      List<enums.UserFilePermissionsUsersPermissions>? usersPermissions}) {
    return UserFilePermissions(
        username: username ?? this.username,
        usersPermissions: usersPermissions ?? this.usersPermissions);
  }
}

@JsonSerializable(explicitToJson: true)
class DiscInfo {
  DiscInfo({
    this.discId,
    this.discName,
  });

  factory DiscInfo.fromJson(Map<String, dynamic> json) =>
      _$DiscInfoFromJson(json);

  @JsonKey(name: 'discId')
  final int? discId;
  @JsonKey(name: 'discName')
  final String? discName;
  static const fromJsonFactory = _$DiscInfoFromJson;
  static const toJsonFactory = _$DiscInfoToJson;
  Map<String, dynamic> toJson() => _$DiscInfoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscInfo &&
            (identical(other.discId, discId) ||
                const DeepCollectionEquality().equals(other.discId, discId)) &&
            (identical(other.discName, discName) ||
                const DeepCollectionEquality()
                    .equals(other.discName, discName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(discId) ^
      const DeepCollectionEquality().hash(discName) ^
      runtimeType.hashCode;
}

extension $DiscInfoExtension on DiscInfo {
  DiscInfo copyWith({int? discId, String? discName}) {
    return DiscInfo(
        discId: discId ?? this.discId, discName: discName ?? this.discName);
  }
}

@JsonSerializable(explicitToJson: true)
class DiscDetails {
  DiscDetails({
    this.discId,
    this.discName,
    this.drivesOnDisc,
  });

  factory DiscDetails.fromJson(Map<String, dynamic> json) =>
      _$DiscDetailsFromJson(json);

  @JsonKey(name: 'discId')
  final int? discId;
  @JsonKey(name: 'discName')
  final String? discName;
  @JsonKey(name: 'drivesOnDisc', defaultValue: <DriveDTO>[])
  final List<DriveDTO>? drivesOnDisc;
  static const fromJsonFactory = _$DiscDetailsFromJson;
  static const toJsonFactory = _$DiscDetailsToJson;
  Map<String, dynamic> toJson() => _$DiscDetailsToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscDetails &&
            (identical(other.discId, discId) ||
                const DeepCollectionEquality().equals(other.discId, discId)) &&
            (identical(other.discName, discName) ||
                const DeepCollectionEquality()
                    .equals(other.discName, discName)) &&
            (identical(other.drivesOnDisc, drivesOnDisc) ||
                const DeepCollectionEquality()
                    .equals(other.drivesOnDisc, drivesOnDisc)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(discId) ^
      const DeepCollectionEquality().hash(discName) ^
      const DeepCollectionEquality().hash(drivesOnDisc) ^
      runtimeType.hashCode;
}

extension $DiscDetailsExtension on DiscDetails {
  DiscDetails copyWith(
      {int? discId, String? discName, List<DriveDTO>? drivesOnDisc}) {
    return DiscDetails(
        discId: discId ?? this.discId,
        discName: discName ?? this.discName,
        drivesOnDisc: drivesOnDisc ?? this.drivesOnDisc);
  }
}

@JsonSerializable(explicitToJson: true)
class DriveDTO {
  DriveDTO({
    this.id,
    this.assignedCapacity,
    this.usedCapacity,
    this.discId,
  });

  factory DriveDTO.fromJson(Map<String, dynamic> json) =>
      _$DriveDTOFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'assignedCapacity')
  final int? assignedCapacity;
  @JsonKey(name: 'usedCapacity')
  final int? usedCapacity;
  @JsonKey(name: 'discId')
  final int? discId;
  static const fromJsonFactory = _$DriveDTOFromJson;
  static const toJsonFactory = _$DriveDTOToJson;
  Map<String, dynamic> toJson() => _$DriveDTOToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DriveDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.assignedCapacity, assignedCapacity) ||
                const DeepCollectionEquality()
                    .equals(other.assignedCapacity, assignedCapacity)) &&
            (identical(other.usedCapacity, usedCapacity) ||
                const DeepCollectionEquality()
                    .equals(other.usedCapacity, usedCapacity)) &&
            (identical(other.discId, discId) ||
                const DeepCollectionEquality().equals(other.discId, discId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(assignedCapacity) ^
      const DeepCollectionEquality().hash(usedCapacity) ^
      const DeepCollectionEquality().hash(discId) ^
      runtimeType.hashCode;
}

extension $DriveDTOExtension on DriveDTO {
  DriveDTO copyWith(
      {int? id, int? assignedCapacity, int? usedCapacity, int? discId}) {
    return DriveDTO(
        id: id ?? this.id,
        assignedCapacity: assignedCapacity ?? this.assignedCapacity,
        usedCapacity: usedCapacity ?? this.usedCapacity,
        discId: discId ?? this.discId);
  }
}

@JsonSerializable(explicitToJson: true)
class GetAuthoritiesInfoResponse {
  GetAuthoritiesInfoResponse({
    this.permissions,
    this.roles,
  });

  factory GetAuthoritiesInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAuthoritiesInfoResponseFromJson(json);

  @JsonKey(name: 'permissions', defaultValue: <String>[])
  final List<String>? permissions;
  @JsonKey(name: 'roles', defaultValue: <RoleInfo>[])
  final List<RoleInfo>? roles;
  static const fromJsonFactory = _$GetAuthoritiesInfoResponseFromJson;
  static const toJsonFactory = _$GetAuthoritiesInfoResponseToJson;
  Map<String, dynamic> toJson() => _$GetAuthoritiesInfoResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetAuthoritiesInfoResponse &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality()
                    .equals(other.permissions, permissions)) &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(permissions) ^
      const DeepCollectionEquality().hash(roles) ^
      runtimeType.hashCode;
}

extension $GetAuthoritiesInfoResponseExtension on GetAuthoritiesInfoResponse {
  GetAuthoritiesInfoResponse copyWith(
      {List<String>? permissions, List<RoleInfo>? roles}) {
    return GetAuthoritiesInfoResponse(
        permissions: permissions ?? this.permissions,
        roles: roles ?? this.roles);
  }
}

@JsonSerializable(explicitToJson: true)
class RoleInfo {
  RoleInfo({
    this.roleName,
    this.aggregatedPermissions,
  });

  factory RoleInfo.fromJson(Map<String, dynamic> json) =>
      _$RoleInfoFromJson(json);

  @JsonKey(name: 'roleName')
  final String? roleName;
  @JsonKey(name: 'aggregatedPermissions', defaultValue: <String>[])
  final List<String>? aggregatedPermissions;
  static const fromJsonFactory = _$RoleInfoFromJson;
  static const toJsonFactory = _$RoleInfoToJson;
  Map<String, dynamic> toJson() => _$RoleInfoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RoleInfo &&
            (identical(other.roleName, roleName) ||
                const DeepCollectionEquality()
                    .equals(other.roleName, roleName)) &&
            (identical(other.aggregatedPermissions, aggregatedPermissions) ||
                const DeepCollectionEquality().equals(
                    other.aggregatedPermissions, aggregatedPermissions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(roleName) ^
      const DeepCollectionEquality().hash(aggregatedPermissions) ^
      runtimeType.hashCode;
}

extension $RoleInfoExtension on RoleInfo {
  RoleInfo copyWith({String? roleName, List<String>? aggregatedPermissions}) {
    return RoleInfo(
        roleName: roleName ?? this.roleName,
        aggregatedPermissions:
            aggregatedPermissions ?? this.aggregatedPermissions);
  }
}

String? filesFilePutFileTypeToJson(
    enums.FilesFilePutFileType? filesFilePutFileType) {
  return enums.$FilesFilePutFileTypeMap[filesFilePutFileType];
}

enums.FilesFilePutFileType filesFilePutFileTypeFromJson(
    String? filesFilePutFileType) {
  if (filesFilePutFileType == null) {
    return enums.FilesFilePutFileType.swaggerGeneratedUnknown;
  }

  return enums.$FilesFilePutFileTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == filesFilePutFileType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.FilesFilePutFileType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> filesFilePutFileTypeListToJson(
    List<enums.FilesFilePutFileType>? filesFilePutFileType) {
  if (filesFilePutFileType == null) {
    return [];
  }

  return filesFilePutFileType
      .map((e) => enums.$FilesFilePutFileTypeMap[e]!)
      .toList();
}

List<enums.FilesFilePutFileType> filesFilePutFileTypeListFromJson(
    List? filesFilePutFileType) {
  if (filesFilePutFileType == null) {
    return [];
  }

  return filesFilePutFileType
      .map((e) => filesFilePutFileTypeFromJson(e.toString()))
      .toList();
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

String? postUserRequestAccountTypeToJson(
    enums.PostUserRequestAccountType? postUserRequestAccountType) {
  return enums.$PostUserRequestAccountTypeMap[postUserRequestAccountType];
}

enums.PostUserRequestAccountType postUserRequestAccountTypeFromJson(
    String? postUserRequestAccountType) {
  if (postUserRequestAccountType == null) {
    return enums.PostUserRequestAccountType.swaggerGeneratedUnknown;
  }

  return enums.$PostUserRequestAccountTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              postUserRequestAccountType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.PostUserRequestAccountType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> postUserRequestAccountTypeListToJson(
    List<enums.PostUserRequestAccountType>? postUserRequestAccountType) {
  if (postUserRequestAccountType == null) {
    return [];
  }

  return postUserRequestAccountType
      .map((e) => enums.$PostUserRequestAccountTypeMap[e]!)
      .toList();
}

List<enums.PostUserRequestAccountType> postUserRequestAccountTypeListFromJson(
    List? postUserRequestAccountType) {
  if (postUserRequestAccountType == null) {
    return [];
  }

  return postUserRequestAccountType
      .map((e) => postUserRequestAccountTypeFromJson(e.toString()))
      .toList();
}

String? getUserWithDetailsResponseAccountTypeToJson(
    enums.GetUserWithDetailsResponseAccountType?
        getUserWithDetailsResponseAccountType) {
  return enums.$GetUserWithDetailsResponseAccountTypeMap[
      getUserWithDetailsResponseAccountType];
}

enums.GetUserWithDetailsResponseAccountType
    getUserWithDetailsResponseAccountTypeFromJson(
        String? getUserWithDetailsResponseAccountType) {
  if (getUserWithDetailsResponseAccountType == null) {
    return enums.GetUserWithDetailsResponseAccountType.swaggerGeneratedUnknown;
  }

  return enums.$GetUserWithDetailsResponseAccountTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              getUserWithDetailsResponseAccountType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.GetUserWithDetailsResponseAccountType
                  .swaggerGeneratedUnknown,
              ''))
      .key;
}

List<String> getUserWithDetailsResponseAccountTypeListToJson(
    List<enums.GetUserWithDetailsResponseAccountType>?
        getUserWithDetailsResponseAccountType) {
  if (getUserWithDetailsResponseAccountType == null) {
    return [];
  }

  return getUserWithDetailsResponseAccountType
      .map((e) => enums.$GetUserWithDetailsResponseAccountTypeMap[e]!)
      .toList();
}

List<enums.GetUserWithDetailsResponseAccountType>
    getUserWithDetailsResponseAccountTypeListFromJson(
        List? getUserWithDetailsResponseAccountType) {
  if (getUserWithDetailsResponseAccountType == null) {
    return [];
  }

  return getUserWithDetailsResponseAccountType
      .map((e) => getUserWithDetailsResponseAccountTypeFromJson(e.toString()))
      .toList();
}

String? getUserResponseAccountTypeToJson(
    enums.GetUserResponseAccountType? getUserResponseAccountType) {
  return enums.$GetUserResponseAccountTypeMap[getUserResponseAccountType];
}

enums.GetUserResponseAccountType getUserResponseAccountTypeFromJson(
    String? getUserResponseAccountType) {
  if (getUserResponseAccountType == null) {
    return enums.GetUserResponseAccountType.swaggerGeneratedUnknown;
  }

  return enums.$GetUserResponseAccountTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              getUserResponseAccountType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.GetUserResponseAccountType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> getUserResponseAccountTypeListToJson(
    List<enums.GetUserResponseAccountType>? getUserResponseAccountType) {
  if (getUserResponseAccountType == null) {
    return [];
  }

  return getUserResponseAccountType
      .map((e) => enums.$GetUserResponseAccountTypeMap[e]!)
      .toList();
}

List<enums.GetUserResponseAccountType> getUserResponseAccountTypeListFromJson(
    List? getUserResponseAccountType) {
  if (getUserResponseAccountType == null) {
    return [];
  }

  return getUserResponseAccountType
      .map((e) => getUserResponseAccountTypeFromJson(e.toString()))
      .toList();
}

String? fileInfoDtoFileTypeToJson(
    enums.FileInfoDtoFileType? fileInfoDtoFileType) {
  return enums.$FileInfoDtoFileTypeMap[fileInfoDtoFileType];
}

enums.FileInfoDtoFileType fileInfoDtoFileTypeFromJson(
    String? fileInfoDtoFileType) {
  if (fileInfoDtoFileType == null) {
    return enums.FileInfoDtoFileType.swaggerGeneratedUnknown;
  }

  return enums.$FileInfoDtoFileTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == fileInfoDtoFileType.toLowerCase(),
          orElse: () => const MapEntry(
              enums.FileInfoDtoFileType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> fileInfoDtoFileTypeListToJson(
    List<enums.FileInfoDtoFileType>? fileInfoDtoFileType) {
  if (fileInfoDtoFileType == null) {
    return [];
  }

  return fileInfoDtoFileType
      .map((e) => enums.$FileInfoDtoFileTypeMap[e]!)
      .toList();
}

List<enums.FileInfoDtoFileType> fileInfoDtoFileTypeListFromJson(
    List? fileInfoDtoFileType) {
  if (fileInfoDtoFileType == null) {
    return [];
  }

  return fileInfoDtoFileType
      .map((e) => fileInfoDtoFileTypeFromJson(e.toString()))
      .toList();
}

String? fileDtoFileTypeToJson(enums.FileDtoFileType? fileDtoFileType) {
  return enums.$FileDtoFileTypeMap[fileDtoFileType];
}

enums.FileDtoFileType fileDtoFileTypeFromJson(String? fileDtoFileType) {
  if (fileDtoFileType == null) {
    return enums.FileDtoFileType.swaggerGeneratedUnknown;
  }

  return enums.$FileDtoFileTypeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == fileDtoFileType.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.FileDtoFileType.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> fileDtoFileTypeListToJson(
    List<enums.FileDtoFileType>? fileDtoFileType) {
  if (fileDtoFileType == null) {
    return [];
  }

  return fileDtoFileType.map((e) => enums.$FileDtoFileTypeMap[e]!).toList();
}

List<enums.FileDtoFileType> fileDtoFileTypeListFromJson(List? fileDtoFileType) {
  if (fileDtoFileType == null) {
    return [];
  }

  return fileDtoFileType
      .map((e) => fileDtoFileTypeFromJson(e.toString()))
      .toList();
}

String? userFilePermissionsUsersPermissionsToJson(
    enums.UserFilePermissionsUsersPermissions?
        userFilePermissionsUsersPermissions) {
  return enums.$UserFilePermissionsUsersPermissionsMap[
      userFilePermissionsUsersPermissions];
}

enums.UserFilePermissionsUsersPermissions
    userFilePermissionsUsersPermissionsFromJson(
        String? userFilePermissionsUsersPermissions) {
  if (userFilePermissionsUsersPermissions == null) {
    return enums.UserFilePermissionsUsersPermissions.swaggerGeneratedUnknown;
  }

  return enums.$UserFilePermissionsUsersPermissionsMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              userFilePermissionsUsersPermissions.toLowerCase(),
          orElse: () => const MapEntry(
              enums.UserFilePermissionsUsersPermissions.swaggerGeneratedUnknown,
              ''))
      .key;
}

List<String> userFilePermissionsUsersPermissionsListToJson(
    List<enums.UserFilePermissionsUsersPermissions>?
        userFilePermissionsUsersPermissions) {
  if (userFilePermissionsUsersPermissions == null) {
    return [];
  }

  return userFilePermissionsUsersPermissions
      .map((e) => enums.$UserFilePermissionsUsersPermissionsMap[e]!)
      .toList();
}

List<enums.UserFilePermissionsUsersPermissions>
    userFilePermissionsUsersPermissionsListFromJson(
        List? userFilePermissionsUsersPermissions) {
  if (userFilePermissionsUsersPermissions == null) {
    return [];
  }

  return userFilePermissionsUsersPermissions
      .map((e) => userFilePermissionsUsersPermissionsFromJson(e.toString()))
      .toList();
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
