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
      parentUUID: json['parentUUID'] as String?,
      hasThumbnail: json['hasThumbnail'] as bool?,
      type: fileInfoDTOTypeFromJson(json['type'] as String?),
      size: json['size'] as int?,
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FileInfoDTOToJson(FileInfoDTO instance) =>
    <String, dynamic>{
      'pubId': instance.pubId,
      'name': instance.name,
      'path': instance.path,
      'parentUUID': instance.parentUUID,
      'hasThumbnail': instance.hasThumbnail,
      'type': fileInfoDTOTypeToJson(instance.type),
      'size': instance.size,
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
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
      pathToProfilePicture: json['pathToProfilePicture'] as String?,
    );

Map<String, dynamic> _$PatchUserRequestToJson(PatchUserRequest instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'pathToProfilePicture': instance.pathToProfilePicture,
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
      pathToProfilePicture: json['pathToProfilePicture'] as String?,
      nickname: json['nickname'] as String?,
      pubId: json['pubId'] as String?,
      roles: userDetailsDTORolesListFromJson(json['roles'] as List?),
    );

Map<String, dynamic> _$UserDetailsDTOToJson(UserDetailsDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'pathToProfilePicture': instance.pathToProfilePicture,
      'nickname': instance.nickname,
      'pubId': instance.pubId,
      'roles': userDetailsDTORolesListToJson(instance.roles),
    };

UserIdDTO _$UserIdDTOFromJson(Map<String, dynamic> json) => UserIdDTO(
      username: json['username'] as String?,
      pubId: json['pubId'] as String?,
      nickname: json['nickname'] as String?,
      pathToProfilePicture: json['pathToProfilePicture'] as String?,
    );

Map<String, dynamic> _$UserIdDTOToJson(UserIdDTO instance) => <String, dynamic>{
      'username': instance.username,
      'pubId': instance.pubId,
      'nickname': instance.nickname,
      'pathToProfilePicture': instance.pathToProfilePicture,
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

FilesImageImageNamePost$RequestBody
    _$FilesImageImageNamePost$RequestBodyFromJson(Map<String, dynamic> json) =>
        FilesImageImageNamePost$RequestBody(
          file: json['file'] as String?,
        );

Map<String, dynamic> _$FilesImageImageNamePost$RequestBodyToJson(
        FilesImageImageNamePost$RequestBody instance) =>
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
