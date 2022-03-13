import 'package:json_annotation/json_annotation.dart';

enum FileInfoDTOType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('DIRECTORY')
  directory,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('PDF')
  pdf,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FileInfoDTOTypeMap = {
  FileInfoDTOType.directory: 'DIRECTORY',
  FileInfoDTOType.image: 'IMAGE',
  FileInfoDTOType.video: 'VIDEO',
  FileInfoDTOType.textFile: 'TEXT_FILE',
  FileInfoDTOType.pdf: 'PDF',
  FileInfoDTOType.music: 'MUSIC',
  FileInfoDTOType.compressed: 'COMPRESSED',
  FileInfoDTOType.undefined: 'UNDEFINED',
  FileInfoDTOType.swaggerGeneratedUnknown: ''
};

enum PostRoleRequestRoles {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MODERATOR')
  moderator,
  @JsonValue('USER')
  user,
  @JsonValue('BOT')
  bot
}

const $PostRoleRequestRolesMap = {
  PostRoleRequestRoles.admin: 'ADMIN',
  PostRoleRequestRoles.moderator: 'MODERATOR',
  PostRoleRequestRoles.user: 'USER',
  PostRoleRequestRoles.bot: 'BOT',
  PostRoleRequestRoles.swaggerGeneratedUnknown: ''
};

enum FileQueryDTOTypes {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('DIRECTORY')
  directory,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('PDF')
  pdf,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FileQueryDTOTypesMap = {
  FileQueryDTOTypes.directory: 'DIRECTORY',
  FileQueryDTOTypes.image: 'IMAGE',
  FileQueryDTOTypes.video: 'VIDEO',
  FileQueryDTOTypes.textFile: 'TEXT_FILE',
  FileQueryDTOTypes.pdf: 'PDF',
  FileQueryDTOTypes.music: 'MUSIC',
  FileQueryDTOTypes.compressed: 'COMPRESSED',
  FileQueryDTOTypes.undefined: 'UNDEFINED',
  FileQueryDTOTypes.swaggerGeneratedUnknown: ''
};

enum PostAddPermissionRequestPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $PostAddPermissionRequestPermissionsMap = {
  PostAddPermissionRequestPermissions.read: 'READ',
  PostAddPermissionRequestPermissions.modify: 'MODIFY',
  PostAddPermissionRequestPermissions.swaggerGeneratedUnknown: ''
};

enum UserDetailsDTORoles {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MODERATOR')
  moderator,
  @JsonValue('USER')
  user,
  @JsonValue('BOT')
  bot
}

const $UserDetailsDTORolesMap = {
  UserDetailsDTORoles.admin: 'ADMIN',
  UserDetailsDTORoles.moderator: 'MODERATOR',
  UserDetailsDTORoles.user: 'USER',
  UserDetailsDTORoles.bot: 'BOT',
  UserDetailsDTORoles.swaggerGeneratedUnknown: ''
};

enum SharedFileInfoDTOType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('DIRECTORY')
  directory,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('PDF')
  pdf,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $SharedFileInfoDTOTypeMap = {
  SharedFileInfoDTOType.directory: 'DIRECTORY',
  SharedFileInfoDTOType.image: 'IMAGE',
  SharedFileInfoDTOType.video: 'VIDEO',
  SharedFileInfoDTOType.textFile: 'TEXT_FILE',
  SharedFileInfoDTOType.pdf: 'PDF',
  SharedFileInfoDTOType.music: 'MUSIC',
  SharedFileInfoDTOType.compressed: 'COMPRESSED',
  SharedFileInfoDTOType.undefined: 'UNDEFINED',
  SharedFileInfoDTOType.swaggerGeneratedUnknown: ''
};

enum SharedFileInfoDTOPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $SharedFileInfoDTOPermissionsMap = {
  SharedFileInfoDTOPermissions.read: 'READ',
  SharedFileInfoDTOPermissions.modify: 'MODIFY',
  SharedFileInfoDTOPermissions.swaggerGeneratedUnknown: ''
};

enum FilesystemObjectDTOType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('DIRECTORY')
  directory,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('PDF')
  pdf,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FilesystemObjectDTOTypeMap = {
  FilesystemObjectDTOType.directory: 'DIRECTORY',
  FilesystemObjectDTOType.image: 'IMAGE',
  FilesystemObjectDTOType.video: 'VIDEO',
  FilesystemObjectDTOType.textFile: 'TEXT_FILE',
  FilesystemObjectDTOType.pdf: 'PDF',
  FilesystemObjectDTOType.music: 'MUSIC',
  FilesystemObjectDTOType.compressed: 'COMPRESSED',
  FilesystemObjectDTOType.undefined: 'UNDEFINED',
  FilesystemObjectDTOType.swaggerGeneratedUnknown: ''
};

enum FilesystemObjectDTOPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $FilesystemObjectDTOPermissionsMap = {
  FilesystemObjectDTOPermissions.read: 'READ',
  FilesystemObjectDTOPermissions.modify: 'MODIFY',
  FilesystemObjectDTOPermissions.swaggerGeneratedUnknown: ''
};

enum PermissionDTOPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $PermissionDTOPermissionsMap = {
  PermissionDTOPermissions.read: 'READ',
  PermissionDTOPermissions.modify: 'MODIFY',
  PermissionDTOPermissions.swaggerGeneratedUnknown: ''
};

enum UserFilePermissionsDTOTypes {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $UserFilePermissionsDTOTypesMap = {
  UserFilePermissionsDTOTypes.read: 'READ',
  UserFilePermissionsDTOTypes.modify: 'MODIFY',
  UserFilePermissionsDTOTypes.swaggerGeneratedUnknown: ''
};

enum DeleteRoleRequestRoles {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MODERATOR')
  moderator,
  @JsonValue('USER')
  user,
  @JsonValue('BOT')
  bot
}

const $DeleteRoleRequestRolesMap = {
  DeleteRoleRequestRoles.admin: 'ADMIN',
  DeleteRoleRequestRoles.moderator: 'MODERATOR',
  DeleteRoleRequestRoles.user: 'USER',
  DeleteRoleRequestRoles.bot: 'BOT',
  DeleteRoleRequestRoles.swaggerGeneratedUnknown: ''
};

enum DeletePermissionsRequestPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('READ')
  read,
  @JsonValue('MODIFY')
  modify
}

const $DeletePermissionsRequestPermissionsMap = {
  DeletePermissionsRequestPermissions.read: 'READ',
  DeletePermissionsRequestPermissions.modify: 'MODIFY',
  DeletePermissionsRequestPermissions.swaggerGeneratedUnknown: ''
};

enum FilesFilePostFileType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('DIRECTORY')
  directory,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('PDF')
  pdf,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FilesFilePostFileTypeMap = {
  FilesFilePostFileType.directory: 'DIRECTORY',
  FilesFilePostFileType.image: 'IMAGE',
  FilesFilePostFileType.video: 'VIDEO',
  FilesFilePostFileType.textFile: 'TEXT_FILE',
  FilesFilePostFileType.pdf: 'PDF',
  FilesFilePostFileType.music: 'MUSIC',
  FilesFilePostFileType.compressed: 'COMPRESSED',
  FilesFilePostFileType.undefined: 'UNDEFINED',
  FilesFilePostFileType.swaggerGeneratedUnknown: ''
};
