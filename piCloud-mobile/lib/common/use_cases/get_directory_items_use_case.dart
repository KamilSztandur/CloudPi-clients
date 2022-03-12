import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/extensions/filesystem_object_dto_type.dart';
import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/use_cases/get_image_preview_use_case.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';

class GetDirectoryItemsUseCase {
  const GetDirectoryItemsUseCase(
    this._authManager,
    this._api,
    this._getImagePreviewUseCase,
  );

  final AuthManager _authManager;
  final Api _api;
  final GetImagePreviewUseCase _getImagePreviewUseCase;

  Future<List<FileItem>?> invoke(String path) async {
    final items = await _getRawList(path);

    if (items != null) {
      return _sortDirectoryItemsByTypeAndName(items);
    } else {
      return null;
    }
  }

  Future<List<FileItem>?> _getRawList(String path) async {
    final fileExplorerItems = <FileItem>[];
    final username = await _authManager.getUsernameOfLoggedUser();

    final result = await _api.filesystemFileStructureGet(
      structureLevels: 1,
      fileStructureRoot: '$username$path',
    );

    for (final dto in result.body?.root?.children ?? <FilesystemObjectDTO>[]) {
      final type = dto.type.toFileExplorerItemType();
      final thumbnail = type == FileExplorerItemType.image
          ? await _getImagePreviewUseCase.invoke(dto.pubId!)
          : null;

      fileExplorerItems.add(
        FileItem(
          id: dto.pubId!,
          title: dto.name!,
          lastModifiedOn: dto.modifiedAt!,
          type: dto.type.toFileExplorerItemType(),
          size: dto.size!.toDouble(),
          thumbnail: thumbnail,
          isFavorite: dto.favourite ?? false,
        ),
      );
    }
    return fileExplorerItems;
  }

  List<FileItem> _sortDirectoryItemsByTypeAndName(List<FileItem> items) {
    return items
      ..sort(
        (a, b) {
          final typeComparison = a.type.index - b.type.index;
          if (typeComparison == 0) {
            return a.title.compareTo(b.title);
          } else {
            return typeComparison;
          }
        },
      );
  }
}
