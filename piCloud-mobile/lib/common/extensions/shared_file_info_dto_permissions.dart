import 'package:app/common/models/file_permission.dart';
import 'package:app/contracts/api.swagger.dart';

extension SharedFileInfoDTOPermissionsExt on SharedFileInfoDTOPermissions {
  FilePermission? toFilePermission() {
    switch (this) {
      case SharedFileInfoDTOPermissions.swaggerGeneratedUnknown:
        return null;
      case SharedFileInfoDTOPermissions.read:
        return FilePermission.read;
      case SharedFileInfoDTOPermissions.modify:
        return FilePermission.modify;
    }
  }
}

extension SharedFileInfoDTOPermissionsIterableExt
    on Iterable<SharedFileInfoDTOPermissions> {
  Set<FilePermission> toFilePermissionSet() {
    if (isEmpty) {
      return FilePermission.values.toSet();
    }

    return map((dto) => dto.toFilePermission())
        .whereType<FilePermission>()
        .toSet();
  }
}
