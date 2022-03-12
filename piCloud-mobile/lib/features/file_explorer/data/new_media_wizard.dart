import 'dart:io';

import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class NewMediaWizard {
  const NewMediaWizard(this._cubit);

  final FileExplorerCubit _cubit;

  Future<List<File>> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      return _parseIntoFileList(result.files);
    } else {
      return <File>[];
    }
  }

  List<File> _parseIntoFileList(List<PlatformFile> pickedFiles) {
    final parsedFiles = <File>[];

    for (final pickedFile in pickedFiles) {
      final path = pickedFile.path;

      if (path != null) {
        parsedFiles.add(File(pickedFile.path!));
      }
    }

    return parsedFiles;
  }

  Future<bool> isNameTaken(String path, String name) async =>
      _cubit.isNameTaken(path, name);

  bool isFilenameLegal(String name) =>
      RegExp(r'^[a-zA-Z0-9\(\). ]+$').hasMatch(name);

  bool isDirectoryNameLegal(String name) =>
      RegExp(r'^[a-zA-Z0-9\(\) ]+$').hasMatch(name);

  Future<File?> takePhoto() async {
    final _picker = ImagePicker();

    final photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final file = File(photo.path);
      return file;
    } else {
      return null;
    }
  }
}
