import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';

enum SearchRange {
  everywhere,
  inThisDirectoryAndTheirSubdirectories,
  onlyInThisDirectory,
}

class FiltersSettingsModel {
  FiltersSettingsModel.withDefaultSettings() {
    allowedFileTypes = _getAllTypes();
    range = SearchRange.everywhere;
  }

  Map<FileExplorerItemType, bool>? allowedFileTypes;
  SearchRange? range;

  Map<FileExplorerItemType, bool> _getAllTypes() {
    final allTypes = <FileExplorerItemType, bool>{};

    for (final type in FileExplorerItemType.values) {
      allTypes.putIfAbsent(type, () => true);
    }

    return allTypes;
  }
}
