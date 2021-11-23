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
    min = DateTime(2000);
    max = DateTime.now();
  }

  FiltersSettingsModel.cloneFrom(FiltersSettingsModel another) {
    allowedFileTypes = Map<FileExplorerItemType, bool>.from(
      another.allowedFileTypes!,
    );

    range = another.range;
    min = another.min;
    max = another.max;
  }

  Map<FileExplorerItemType, bool>? allowedFileTypes;
  SearchRange? range;
  DateTime? min, max;

  Map<FileExplorerItemType, bool> _getAllTypes() {
    final allTypes = <FileExplorerItemType, bool>{};

    for (final type in FileExplorerItemType.values) {
      allTypes.putIfAbsent(type, () => true);
    }

    return allTypes;
  }
}
