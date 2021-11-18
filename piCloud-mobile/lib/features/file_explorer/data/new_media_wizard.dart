import 'dart:io';

import 'package:file_picker/file_picker.dart';

class NewMediaWizard {
  Future<List<File>> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      return _parseIntoFileList(result.files);
    } else {
      return <File>[];
    }
  }

  List<File> _parseIntoFileList(List<PlatformFile> pickedFiles) {
    List<File> parsedFiles = <File>[];

    pickedFiles.forEach((PlatformFile pickedFile) {
      String? path = pickedFile.path;

      if (path != null) {
        parsedFiles.add(File(pickedFile.path!));
      }
    });

    return parsedFiles;
  }
}
