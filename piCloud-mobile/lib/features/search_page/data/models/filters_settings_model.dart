import 'package:app/common/models/file_explorer_item_type.dart';

enum SearchRange {
  everywhere,
  inThisDirectoryAndTheirSubdirectories,
}

class FiltersSettingsModel {
  FiltersSettingsModel.withDefaultSettings() {
    allowedFileTypes = _getAllTypes();
    range = SearchRange.everywhere;
    minDate = DateTime(2000);
    maxDate = DateTime.now();
    matchLetterCases = true;
    matchWholeWords = true;
  }

  FiltersSettingsModel.cloneFrom(FiltersSettingsModel another) {
    allowedFileTypes = Map<FileExplorerItemType, bool>.from(
      another.allowedFileTypes!,
    );

    range = another.range;
    minDate = another.minDate;
    maxDate = another.maxDate;
    matchLetterCases = another.matchLetterCases;
    matchWholeWords = another.matchWholeWords;
  }

  Map<FileExplorerItemType, bool>? allowedFileTypes;
  SearchRange? range;
  DateTime? minDate, maxDate;
  bool? matchLetterCases, matchWholeWords;

  Map<FileExplorerItemType, bool> _getAllTypes() {
    final allTypes = <FileExplorerItemType, bool>{};

    for (final type in FileExplorerItemType.values) {
      allTypes.putIfAbsent(type, () => true);
    }

    return allTypes;
  }
}
