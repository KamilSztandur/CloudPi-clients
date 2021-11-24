// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserRequest _$PostUserRequestFromJson(Map<String, dynamic> json) =>
    PostUserRequest(
      login: json['login'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      accountType:
          postUserRequestAccountTypeFromJson(json['accountType'] as String?),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PostUserRequestToJson(PostUserRequest instance) =>
    <String, dynamic>{
      'login': instance.login,
      'username': instance.username,
      'password': instance.password,
      'accountType': postUserRequestAccountTypeToJson(instance.accountType),
      'email': instance.email,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      login: json['login'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };

UpdateUserDetailsRequest _$UpdateUserDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserDetailsRequest(
      username: json['username'] as String?,
      email: json['email'] as String?,
      pathToProfilePicture: json['pathToProfilePicture'] as String?,
    );

Map<String, dynamic> _$UpdateUserDetailsRequestToJson(
        UpdateUserDetailsRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'pathToProfilePicture': instance.pathToProfilePicture,
    };

GetUserWithDetailsResponse _$GetUserWithDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserWithDetailsResponse(
      username: json['username'] as String?,
      email: json['email'] as String?,
      isLocked: json['isLocked'] as bool?,
      accountType: getUserWithDetailsResponseAccountTypeFromJson(
          json['accountType'] as String?),
      usersPermissions: (json['usersPermissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      usersRoles: (json['usersRoles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetUserWithDetailsResponseToJson(
        GetUserWithDetailsResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'isLocked': instance.isLocked,
      'accountType':
          getUserWithDetailsResponseAccountTypeToJson(instance.accountType),
      'usersPermissions': instance.usersPermissions,
      'usersRoles': instance.usersRoles,
    };

GetUserResponse _$GetUserResponseFromJson(Map<String, dynamic> json) =>
    GetUserResponse(
      username: json['username'] as String?,
      pathToProfilePicture: json['pathToProfilePicture'] as String?,
      accountType:
          getUserResponseAccountTypeFromJson(json['accountType'] as String?),
    );

Map<String, dynamic> _$GetUserResponseToJson(GetUserResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'pathToProfilePicture': instance.pathToProfilePicture,
      'accountType': getUserResponseAccountTypeToJson(instance.accountType),
    };

GetUserDriveInfo _$GetUserDriveInfoFromJson(Map<String, dynamic> json) =>
    GetUserDriveInfo(
      username: json['username'] as String?,
      assignedSpace: json['assignedSpace'] as int?,
      usedSpace: json['usedSpace'] as int?,
    );

Map<String, dynamic> _$GetUserDriveInfoToJson(GetUserDriveInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'assignedSpace': instance.assignedSpace,
      'usedSpace': instance.usedSpace,
    };

DirectoryInfoDto _$DirectoryInfoDtoFromJson(Map<String, dynamic> json) =>
    DirectoryInfoDto(
      name: json['name'] as String?,
      size: json['size'] as int?,
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DirectoryInfoDtoToJson(DirectoryInfoDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'id': instance.id,
    };

FSDirectoryDTO _$FSDirectoryDTOFromJson(Map<String, dynamic> json) =>
    FSDirectoryDTO(
      id: json['id'] as String?,
      details: json['details'] == null
          ? null
          : DirectoryInfoDto.fromJson(json['details'] as Map<String, dynamic>),
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => FSFileDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      directories: (json['directories'] as List<dynamic>?)
              ?.map((e) => FSDirectoryDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FSDirectoryDTOToJson(FSDirectoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'details': instance.details?.toJson(),
      'files': instance.files?.map((e) => e.toJson()).toList(),
      'directories': instance.directories?.map((e) => e.toJson()).toList(),
    };

FSFileDTO _$FSFileDTOFromJson(Map<String, dynamic> json) => FSFileDTO(
      id: json['id'] as String?,
      details: json['details'] == null
          ? null
          : FileInfoDto.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FSFileDTOToJson(FSFileDTO instance) => <String, dynamic>{
      'id': instance.id,
      'details': instance.details?.toJson(),
    };

FileInfoDto _$FileInfoDtoFromJson(Map<String, dynamic> json) => FileInfoDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      fileType: fileInfoDtoFileTypeFromJson(json['fileType'] as String?),
      hasThumbnail: json['hasThumbnail'] as bool?,
    );

Map<String, dynamic> _$FileInfoDtoToJson(FileInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'fileType': fileInfoDtoFileTypeToJson(instance.fileType),
      'hasThumbnail': instance.hasThumbnail,
    };

FileStructureDTO _$FileStructureDTOFromJson(Map<String, dynamic> json) =>
    FileStructureDTO(
      depth: json['depth'] as int?,
      rootDirectoryPath: json['rootDirectoryPath'] as String?,
      rootDirectory: json['rootDirectory'] == null
          ? null
          : FSDirectoryDTO.fromJson(
              json['rootDirectory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileStructureDTOToJson(FileStructureDTO instance) =>
    <String, dynamic>{
      'depth': instance.depth,
      'rootDirectoryPath': instance.rootDirectoryPath,
      'rootDirectory': instance.rootDirectory?.toJson(),
    };

FileDto _$FileDtoFromJson(Map<String, dynamic> json) => FileDto(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      driveId: json['driveId'] as int?,
      fileName: json['fileName'] as String?,
      fileType: fileDtoFileTypeFromJson(json['fileType'] as String?),
      path: json['path'] as String?,
      size: json['size'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$FileDtoToJson(FileDto instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'driveId': instance.driveId,
      'fileName': instance.fileName,
      'fileType': fileDtoFileTypeToJson(instance.fileType),
      'path': instance.path,
      'size': instance.size,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };

GetFilePermissionsResponse _$GetFilePermissionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetFilePermissionsResponse(
      discObjectId: json['discObjectId'] as int?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) =>
                  UserFilePermissions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetFilePermissionsResponseToJson(
        GetFilePermissionsResponse instance) =>
    <String, dynamic>{
      'discObjectId': instance.discObjectId,
      'permissions': instance.permissions?.map((e) => e.toJson()).toList(),
    };

UserFilePermissions _$UserFilePermissionsFromJson(Map<String, dynamic> json) =>
    UserFilePermissions(
      username: json['username'] as String?,
      usersPermissions: userFilePermissionsUsersPermissionsListFromJson(
          json['usersPermissions'] as List?),
    );

Map<String, dynamic> _$UserFilePermissionsToJson(
        UserFilePermissions instance) =>
    <String, dynamic>{
      'username': instance.username,
      'usersPermissions': userFilePermissionsUsersPermissionsListToJson(
          instance.usersPermissions),
    };

DiscInfo _$DiscInfoFromJson(Map<String, dynamic> json) => DiscInfo(
      discId: json['discId'] as int?,
      discName: json['discName'] as String?,
    );

Map<String, dynamic> _$DiscInfoToJson(DiscInfo instance) => <String, dynamic>{
      'discId': instance.discId,
      'discName': instance.discName,
    };

DiscDetails _$DiscDetailsFromJson(Map<String, dynamic> json) => DiscDetails(
      discId: json['discId'] as int?,
      discName: json['discName'] as String?,
      drivesOnDisc: (json['drivesOnDisc'] as List<dynamic>?)
              ?.map((e) => DriveDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscDetailsToJson(DiscDetails instance) =>
    <String, dynamic>{
      'discId': instance.discId,
      'discName': instance.discName,
      'drivesOnDisc': instance.drivesOnDisc?.map((e) => e.toJson()).toList(),
    };

DriveDTO _$DriveDTOFromJson(Map<String, dynamic> json) => DriveDTO(
      id: json['id'] as int?,
      assignedCapacity: json['assignedCapacity'] as int?,
      usedCapacity: json['usedCapacity'] as int?,
      discId: json['discId'] as int?,
    );

Map<String, dynamic> _$DriveDTOToJson(DriveDTO instance) => <String, dynamic>{
      'id': instance.id,
      'assignedCapacity': instance.assignedCapacity,
      'usedCapacity': instance.usedCapacity,
      'discId': instance.discId,
    };

GetAuthoritiesInfoResponse _$GetAuthoritiesInfoResponseFromJson(
        Map<String, dynamic> json) =>
    GetAuthoritiesInfoResponse(
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => RoleInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAuthoritiesInfoResponseToJson(
        GetAuthoritiesInfoResponse instance) =>
    <String, dynamic>{
      'permissions': instance.permissions,
      'roles': instance.roles?.map((e) => e.toJson()).toList(),
    };

RoleInfo _$RoleInfoFromJson(Map<String, dynamic> json) => RoleInfo(
      roleName: json['roleName'] as String?,
      aggregatedPermissions: (json['aggregatedPermissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$RoleInfoToJson(RoleInfo instance) => <String, dynamic>{
      'roleName': instance.roleName,
      'aggregatedPermissions': instance.aggregatedPermissions,
    };
