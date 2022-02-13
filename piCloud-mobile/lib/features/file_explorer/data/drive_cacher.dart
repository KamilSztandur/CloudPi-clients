import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';

class DriveCacher {
  DriveCacher(this._api);

  final Api _api;
  FilesystemObjectDTO? fileSystemCache;

  Future<void> initialize() async {
    final response = await _api.filesystemFileStructureGet(
      structureLevels: 1000,
    );

    fileSystemCache = response.body?.root;
  }

  List<FilesystemObjectDTO> getContentsOf(String path) {
    if (fileSystemCache == null) {
      throw Exception('DriveCacher not initialized.');
    }
    //TODO
    return [];
  }
}
