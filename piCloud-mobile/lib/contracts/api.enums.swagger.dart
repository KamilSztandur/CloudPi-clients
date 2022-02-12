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
  FileInfoDTOType.music: 'MUSIC',
  FileInfoDTOType.compressed: 'COMPRESSED',
  FileInfoDTOType.undefined: 'UNDEFINED',
  FileInfoDTOType.swaggerGeneratedUnknown: ''
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
  FilesFilePostFileType.music: 'MUSIC',
  FilesFilePostFileType.compressed: 'COMPRESSED',
  FilesFilePostFileType.undefined: 'UNDEFINED',
  FilesFilePostFileType.swaggerGeneratedUnknown: ''
};
