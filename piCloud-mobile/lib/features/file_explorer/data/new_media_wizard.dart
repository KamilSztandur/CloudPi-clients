import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

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

  //WARNING: MOCK -> TODO
  bool isDirectoryNameTaken(String name) => false;

  bool isNameLegal(String name) => RegExp(r'^[a-zA-Z0-9\(\)]+$').hasMatch(name);

  Future<File?> takePhoto() async {
    final ImagePicker _picker = ImagePicker();

    XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      File file = File(photo.path);
      return file;
    } else {
      return null;
    }
  }
}
