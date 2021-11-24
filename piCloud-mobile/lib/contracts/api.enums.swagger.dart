import 'package:json_annotation/json_annotation.dart';

enum PostUserRequestAccountType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('USER')
  user,
  @JsonValue('ROOT')
  root,
  @JsonValue('SERVICE_WORKER')
  serviceWorker
}

const $PostUserRequestAccountTypeMap = {
  PostUserRequestAccountType.user: 'USER',
  PostUserRequestAccountType.root: 'ROOT',
  PostUserRequestAccountType.serviceWorker: 'SERVICE_WORKER',
  PostUserRequestAccountType.swaggerGeneratedUnknown: ''
};

enum GetUserWithDetailsResponseAccountType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('USER')
  user,
  @JsonValue('ROOT')
  root,
  @JsonValue('SERVICE_WORKER')
  serviceWorker
}

const $GetUserWithDetailsResponseAccountTypeMap = {
  GetUserWithDetailsResponseAccountType.user: 'USER',
  GetUserWithDetailsResponseAccountType.root: 'ROOT',
  GetUserWithDetailsResponseAccountType.serviceWorker: 'SERVICE_WORKER',
  GetUserWithDetailsResponseAccountType.swaggerGeneratedUnknown: ''
};

enum GetUserResponseAccountType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('USER')
  user,
  @JsonValue('ROOT')
  root,
  @JsonValue('SERVICE_WORKER')
  serviceWorker
}

const $GetUserResponseAccountTypeMap = {
  GetUserResponseAccountType.user: 'USER',
  GetUserResponseAccountType.root: 'ROOT',
  GetUserResponseAccountType.serviceWorker: 'SERVICE_WORKER',
  GetUserResponseAccountType.swaggerGeneratedUnknown: ''
};

enum FileInfoDtoFileType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FileInfoDtoFileTypeMap = {
  FileInfoDtoFileType.image: 'IMAGE',
  FileInfoDtoFileType.video: 'VIDEO',
  FileInfoDtoFileType.textFile: 'TEXT_FILE',
  FileInfoDtoFileType.music: 'MUSIC',
  FileInfoDtoFileType.compressed: 'COMPRESSED',
  FileInfoDtoFileType.undefined: 'UNDEFINED',
  FileInfoDtoFileType.swaggerGeneratedUnknown: ''
};

enum FileDtoFileType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FileDtoFileTypeMap = {
  FileDtoFileType.image: 'IMAGE',
  FileDtoFileType.video: 'VIDEO',
  FileDtoFileType.textFile: 'TEXT_FILE',
  FileDtoFileType.music: 'MUSIC',
  FileDtoFileType.compressed: 'COMPRESSED',
  FileDtoFileType.undefined: 'UNDEFINED',
  FileDtoFileType.swaggerGeneratedUnknown: ''
};

enum UserFilePermissionsUsersPermissions {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('CREATE')
  create,
  @JsonValue('READ')
  read,
  @JsonValue('UPDATE')
  update,
  @JsonValue('DELETE')
  delete
}

const $UserFilePermissionsUsersPermissionsMap = {
  UserFilePermissionsUsersPermissions.create: 'CREATE',
  UserFilePermissionsUsersPermissions.read: 'READ',
  UserFilePermissionsUsersPermissions.update: 'UPDATE',
  UserFilePermissionsUsersPermissions.delete: 'DELETE',
  UserFilePermissionsUsersPermissions.swaggerGeneratedUnknown: ''
};

enum FilesFilePutFileType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FilesFilePutFileTypeMap = {
  FilesFilePutFileType.image: 'IMAGE',
  FilesFilePutFileType.video: 'VIDEO',
  FilesFilePutFileType.textFile: 'TEXT_FILE',
  FilesFilePutFileType.music: 'MUSIC',
  FilesFilePutFileType.compressed: 'COMPRESSED',
  FilesFilePutFileType.undefined: 'UNDEFINED',
  FilesFilePutFileType.swaggerGeneratedUnknown: ''
};

enum FilesFilePostFileType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('TEXT_FILE')
  textFile,
  @JsonValue('MUSIC')
  music,
  @JsonValue('COMPRESSED')
  compressed,
  @JsonValue('UNDEFINED')
  undefined
}

const $FilesFilePostFileTypeMap = {
  FilesFilePostFileType.image: 'IMAGE',
  FilesFilePostFileType.video: 'VIDEO',
  FilesFilePostFileType.textFile: 'TEXT_FILE',
  FilesFilePostFileType.music: 'MUSIC',
  FilesFilePostFileType.compressed: 'COMPRESSED',
  FilesFilePostFileType.undefined: 'UNDEFINED',
  FilesFilePostFileType.swaggerGeneratedUnknown: ''
};
