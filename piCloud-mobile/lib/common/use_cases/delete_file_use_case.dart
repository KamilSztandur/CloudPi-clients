import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/contracts/client_index.dart';

class DeleteFileUseCase {
  const DeleteFileUseCase(this._api);

  final Api _api;

  Future<bool> invoke(FileItem file) {
    if (file.type == FileExplorerItemType.directory) {
      return _api
          .filesystemDirectoryDirectoryIdDelete(directoryId: file.id)
          .then((result) => result.isSuccessful);
    } else {
      return _api
          .filesFileFileIdDelete(fileId: file.id)
          .then((result) => result.isSuccessful);
    }
  }
}
