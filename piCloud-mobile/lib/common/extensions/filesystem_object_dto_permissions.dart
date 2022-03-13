import 'package:app/common/models/file_permission.dart';
import 'package:app/contracts/api.swagger.dart';

extension FilesystemObjectDTOPermissionsExt on FilesystemObjectDTOPermissions {
  FilePermission? toFilePermission() {
    switch (this) {
      case FilesystemObjectDTOPermissions.swaggerGeneratedUnknown:
        return null;
      case FilesystemObjectDTOPermissions.read:
        return FilePermission.read;
      case FilesystemObjectDTOPermissions.modify:
        return FilePermission.modify;
    }
  }
}

extension FilesystemObjectDTOPermissionsIterableExt
    on Iterable<FilesystemObjectDTOPermissions> {
  Set<FilePermission> toFilePermissionSet() {
    if (isEmpty) {
      return FilePermission.values.toSet();
    }

    return map((dto) => dto.toFilePermission())
        .whereType<FilePermission>()
        .toSet();
  }
}
