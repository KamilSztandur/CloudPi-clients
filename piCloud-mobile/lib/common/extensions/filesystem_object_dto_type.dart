import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/contracts/api.swagger.dart';

extension FileInfoDTOTypeExt on FilesystemObjectDTOType? {
  FileExplorerItemType toFileExplorerItemType() {
    switch (this) {
      case FilesystemObjectDTOType.directory:
        return FileExplorerItemType.directory;
      case FilesystemObjectDTOType.image:
        return FileExplorerItemType.image;
      case FilesystemObjectDTOType.video:
        return FileExplorerItemType.directory;
      case FilesystemObjectDTOType.textFile:
        return FileExplorerItemType.text;
      case FilesystemObjectDTOType.music:
        return FileExplorerItemType.music;
      case FilesystemObjectDTOType.compressed:
        return FileExplorerItemType.compressed;
      case FilesystemObjectDTOType.pdf:
        return FileExplorerItemType.pdf;
      default:
        return FileExplorerItemType.file;
    }
  }
}
