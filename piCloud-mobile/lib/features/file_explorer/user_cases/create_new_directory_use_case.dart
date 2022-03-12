import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';

class CreateNewDirectoryUseCase {
  const CreateNewDirectoryUseCase(
    this._authManager,
    this._api,
  );

  final AuthManager _authManager;
  final Api _api;

  Future<bool> invoke(String path, String name) async {
    final username = await _authManager.getUsernameOfLoggedUser();
    final result = await _api.filesystemDirectoryPut(
      directoryPath: '$username$path$name',
    );

    return result.isSuccessful;
  }
}
