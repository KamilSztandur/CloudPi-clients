import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/contracts/api.swagger.dart';

extension FileInfoDTOTypeExt on FileInfoDTOType? {
  FileExplorerItemType toFileExplorerItemType() {
    switch (this) {
      case FileInfoDTOType.directory:
        return FileExplorerItemType.directory;
      case FileInfoDTOType.image:
        return FileExplorerItemType.image;
      case FileInfoDTOType.video:
        return FileExplorerItemType.directory;
      case FileInfoDTOType.textFile:
        return FileExplorerItemType.text;
      case FileInfoDTOType.music:
        return FileExplorerItemType.music;
      case FileInfoDTOType.compressed:
        return FileExplorerItemType.file;
      case FileInfoDTOType.pdf:
        return FileExplorerItemType.pdf;
      default:
        return FileExplorerItemType.file;
    }
  }
}
