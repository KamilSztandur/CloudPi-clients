import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';

class RenameFileUseCase {
  const RenameFileUseCase(
    this._authManager,
    this._api,
  );

  final AuthManager _authManager;
  final Api _api;

  Future<bool> invoke(
    String containingDirectoryPath,
    String newName,
    String pubId,
  ) async {
    final path =
        '${await _authManager.getUsernameOfLoggedUser()}$containingDirectoryPath$newName';

    final result = await _api.filesystemMovePatch(
      body: MoveFileRequest(filePubId: pubId, newPath: path),
    );

    return result.isSuccessful;
  }
}
