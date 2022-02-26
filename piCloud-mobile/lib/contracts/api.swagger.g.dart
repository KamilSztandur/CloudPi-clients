// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorBody _$ErrorBodyFromJson(Map<String, dynamic> json) => ErrorBody(
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$ErrorBodyToJson(ErrorBody instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
    };

FileInfoDTO _$FileInfoDTOFromJson(Map<String, dynamic> json) => FileInfoDTO(
      pubId: json['pubId'] as String?,
      name: json['name'] as String?,
      path: json['path'] as String?,
      hasThumbnail: json['hasThumbnail'] as bool?,
      type: fileInfoDTOTypeFromJson(json['type'] as String?),
      size: json['size'] as int?,
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isFavourite: json['isFavourite'] as bool?,
    );

Map<String, dynamic> _$FileInfoDTOToJson(FileInfoDTO instance) =>
    <String, dynamic>{
      'pubId': instance.pubId,
      'name': instance.name,
      'path': instance.path,
      'hasThumbnail': instance.hasThumbnail,
      'type': fileInfoDTOTypeToJson(instance.type),
      'size': instance.size,
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'isFavourite': instance.isFavourite,
    };

PostUserRequest _$PostUserRequestFromJson(Map<String, dynamic> json) =>
    PostUserRequest(
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$PostUserRequestToJson(PostUserRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'nickname': instance.nickname,
      'email': instance.email,
      'password': instance.password,
    };

PostRoleRequest _$PostRoleRequestFromJson(Map<String, dynamic> json) =>
    PostRoleRequest(
      roles: postRoleRequestRolesListFromJson(json['roles'] as List?),
      username: json['username'] as String?,
    );

Map<String, dynamic> _$PostRoleRequestToJson(PostRoleRequest instance) =>
    <String, dynamic>{
      'roles': postRoleRequestRolesListToJson(instance.roles),
      'username': instance.username,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

FileQueryDTO _$FileQueryDTOFromJson(Map<String, dynamic> json) => FileQueryDTO(
      name: json['name'] as String?,
      type: fileQueryDTOTypeFromJson(json['type'] as String?),
      created: json['created'] == null
          ? null
          : TimePeriod.fromJson(json['created'] as Map<String, dynamic>),
      lastModified: json['lastModified'] == null
          ? null
          : TimePeriod.fromJson(json['lastModified'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileQueryDTOToJson(FileQueryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': fileQueryDTOTypeToJson(instance.type),
      'created': instance.created?.toJson(),
      'lastModified': instance.lastModified?.toJson(),
    };

TimePeriod _$TimePeriodFromJson(Map<String, dynamic> json) => TimePeriod(
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$TimePeriodToJson(TimePeriod instance) =>
    <String, dynamic>{
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
    };

GetFileByPathRequest _$GetFileByPathRequestFromJson(
        Map<String, dynamic> json) =>
    GetFileByPathRequest(
      filePaths: (json['filePaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetFileByPathRequestToJson(
        GetFileByPathRequest instance) =>
    <String, dynamic>{
      'filePaths': instance.filePaths,
    };

PostAddPermissionRequest _$PostAddPermissionRequestFromJson(
        Map<String, dynamic> json) =>
    PostAddPermissionRequest(
      filePubId: json['filePubId'] as String?,
      ownerUsername: json['ownerUsername'] as String?,
      permissions: postAddPermissionRequestPermissionsListFromJson(
          json['permissions'] as List?),
    );

Map<String, dynamic> _$PostAddPermissionRequestToJson(
        PostAddPermissionRequest instance) =>
    <String, dynamic>{
      'filePubId': instance.filePubId,
      'ownerUsername': instance.ownerUsername,
      'permissions':
          postAddPermissionRequestPermissionsListToJson(instance.permissions),
    };

PostDriveRequest _$PostDriveRequestFromJson(Map<String, dynamic> json) =>
    PostDriveRequest(
      path: json['path'] as String?,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$PostDriveRequestToJson(PostDriveRequest instance) =>
    <String, dynamic>{
      'path': instance.path,
      'size': instance.size,
    };

DriveDTO _$DriveDTOFromJson(Map<String, dynamic> json) => DriveDTO(
      pubId: json['pubId'] as String?,
      path: json['path'] as String?,
      assignedSpace: json['assignedSpace'] as int?,
      freeSpace: json['freeSpace'] as int?,
    );

Map<String, dynamic> _$DriveDTOToJson(DriveDTO instance) => <String, dynamic>{
      'pubId': instance.pubId,
      'path': instance.path,
      'assignedSpace': instance.assignedSpace,
      'freeSpace': instance.freeSpace,
    };

PatchUserRequest _$PatchUserRequestFromJson(Map<String, dynamic> json) =>
    PatchUserRequest(
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      profilePicturePubId: json['profilePicturePubId'] as String?,
    );

Map<String, dynamic> _$PatchUserRequestToJson(PatchUserRequest instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'profilePicturePubId': instance.profilePicturePubId,
    };

MoveFileRequest _$MoveFileRequestFromJson(Map<String, dynamic> json) =>
    MoveFileRequest(
      filePubId: json['filePubId'] as String?,
      newPath: json['newPath'] as String?,
    );

Map<String, dynamic> _$MoveFileRequestToJson(MoveFileRequest instance) =>
    <String, dynamic>{
      'filePubId': instance.filePubId,
      'newPath': instance.newPath,
    };

UserDetailsDTO _$UserDetailsDTOFromJson(Map<String, dynamic> json) =>
    UserDetailsDTO(
      username: json['username'] as String?,
      email: json['email'] as String?,
      profilePicturePubId: json['profilePicturePubId'] as String?,
      nickname: json['nickname'] as String?,
      pubId: json['pubId'] as String?,
      roles: userDetailsDTORolesListFromJson(json['roles'] as List?),
    );

Map<String, dynamic> _$UserDetailsDTOToJson(UserDetailsDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'profilePicturePubId': instance.profilePicturePubId,
      'nickname': instance.nickname,
      'pubId': instance.pubId,
      'roles': userDetailsDTORolesListToJson(instance.roles),
    };

UserIdDTO _$UserIdDTOFromJson(Map<String, dynamic> json) => UserIdDTO(
      username: json['username'] as String?,
      pubId: json['pubId'] as String?,
      nickname: json['nickname'] as String?,
      profilePicturePubId: json['profilePicturePubId'] as String?,
    );

Map<String, dynamic> _$UserIdDTOToJson(UserIdDTO instance) => <String, dynamic>{
      'username': instance.username,
      'pubId': instance.pubId,
      'nickname': instance.nickname,
      'profilePicturePubId': instance.profilePicturePubId,
    };

FilesystemInfoDTO _$FilesystemInfoDTOFromJson(Map<String, dynamic> json) =>
    FilesystemInfoDTO(
      ownerUsername: json['ownerUsername'] as String?,
      totalSpace: json['totalSpace'] as int?,
      freeSpace: json['freeSpace'] as int?,
    );

Map<String, dynamic> _$FilesystemInfoDTOToJson(FilesystemInfoDTO instance) =>
    <String, dynamic>{
      'ownerUsername': instance.ownerUsername,
      'totalSpace': instance.totalSpace,
      'freeSpace': instance.freeSpace,
    };

FileStructureDTO _$FileStructureDTOFromJson(Map<String, dynamic> json) =>
    FileStructureDTO(
      path: json['path'] as String?,
      root: json['root'] == null
          ? null
          : FilesystemObjectDTO.fromJson(json['root'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileStructureDTOToJson(FileStructureDTO instance) =>
    <String, dynamic>{
      'path': instance.path,
      'root': instance.root?.toJson(),
    };

FilesystemObjectDTO _$FilesystemObjectDTOFromJson(Map<String, dynamic> json) =>
    FilesystemObjectDTO(
      pubId: json['pubId'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      version: json['version'] as int?,
      type: filesystemObjectDTOTypeFromJson(json['type'] as String?),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) =>
                  FilesystemObjectDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FilesystemObjectDTOToJson(
        FilesystemObjectDTO instance) =>
    <String, dynamic>{
      'pubId': instance.pubId,
      'name': instance.name,
      'size': instance.size,
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'version': instance.version,
      'type': filesystemObjectDTOTypeToJson(instance.type),
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };

FilePermissionsDTO _$FilePermissionsDTOFromJson(Map<String, dynamic> json) =>
    FilePermissionsDTO(
      filePubId: json['filePubId'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => PermissionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FilePermissionsDTOToJson(FilePermissionsDTO instance) =>
    <String, dynamic>{
      'filePubId': instance.filePubId,
      'permissions': instance.permissions?.map((e) => e.toJson()).toList(),
    };

PermissionDTO _$PermissionDTOFromJson(Map<String, dynamic> json) =>
    PermissionDTO(
      ownerUsername: json['ownerUsername'] as String?,
      permissions:
          permissionDTOPermissionsListFromJson(json['permissions'] as List?),
    );

Map<String, dynamic> _$PermissionDTOToJson(PermissionDTO instance) =>
    <String, dynamic>{
      'ownerUsername': instance.ownerUsername,
      'permissions': permissionDTOPermissionsListToJson(instance.permissions),
    };

UserFilePermissionsDTO _$UserFilePermissionsDTOFromJson(
        Map<String, dynamic> json) =>
    UserFilePermissionsDTO(
      types: userFilePermissionsDTOTypesListFromJson(json['types'] as List?),
      username: json['username'] as String?,
      filePubId: json['filePubId'] as String?,
    );

Map<String, dynamic> _$UserFilePermissionsDTOToJson(
        UserFilePermissionsDTO instance) =>
    <String, dynamic>{
      'types': userFilePermissionsDTOTypesListToJson(instance.types),
      'username': instance.username,
      'filePubId': instance.filePubId,
    };

DiscDTO _$DiscDTOFromJson(Map<String, dynamic> json) => DiscDTO(
      discName: json['discName'] as String?,
      discSize: json['discSize'] as int?,
      discSpaceAvailable: json['discSpaceAvailable'] as int?,
    );

Map<String, dynamic> _$DiscDTOToJson(DiscDTO instance) => <String, dynamic>{
      'discName': instance.discName,
      'discSize': instance.discSize,
      'discSpaceAvailable': instance.discSpaceAvailable,
    };

DeleteRoleRequest _$DeleteRoleRequestFromJson(Map<String, dynamic> json) =>
    DeleteRoleRequest(
      roles: deleteRoleRequestRolesListFromJson(json['roles'] as List?),
      username: json['username'] as String?,
    );

Map<String, dynamic> _$DeleteRoleRequestToJson(DeleteRoleRequest instance) =>
    <String, dynamic>{
      'roles': deleteRoleRequestRolesListToJson(instance.roles),
      'username': instance.username,
    };

DeletePermissionsRequest _$DeletePermissionsRequestFromJson(
        Map<String, dynamic> json) =>
    DeletePermissionsRequest(
      filePubId: json['filePubId'] as String?,
      ownerUsername: json['ownerUsername'] as String?,
      permissions: deletePermissionsRequestPermissionsListFromJson(
          json['permissions'] as List?),
    );

Map<String, dynamic> _$DeletePermissionsRequestToJson(
        DeletePermissionsRequest instance) =>
    <String, dynamic>{
      'filePubId': instance.filePubId,
      'ownerUsername': instance.ownerUsername,
      'permissions':
          deletePermissionsRequestPermissionsListToJson(instance.permissions),
    };

DeleteAllPermissionsRequest _$DeleteAllPermissionsRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteAllPermissionsRequest(
      filePubId: json['filePubId'] as String?,
    );

Map<String, dynamic> _$DeleteAllPermissionsRequestToJson(
        DeleteAllPermissionsRequest instance) =>
    <String, dynamic>{
      'filePubId': instance.filePubId,
    };

FilesImagePost$RequestBody _$FilesImagePost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    FilesImagePost$RequestBody(
      file: json['file'] as String?,
    );

Map<String, dynamic> _$FilesImagePost$RequestBodyToJson(
        FilesImagePost$RequestBody instance) =>
    <String, dynamic>{
      'file': instance.file,
    };

FilesFilePost$RequestBody _$FilesFilePost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    FilesFilePost$RequestBody(
      file: json['file'] as String?,
    );

Map<String, dynamic> _$FilesFilePost$RequestBodyToJson(
        FilesFilePost$RequestBody instance) =>
    <String, dynamic>{
      'file': instance.file,
    };
