import 'dart:io';

import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/common/use_cases/delete_file_use_case.dart';
import 'package:app/common/use_cases/download_file_use_case.dart';
import 'package:app/common/use_cases/get_directory_items_use_case.dart';
import 'package:app/common/use_cases/rename_file_use_case.dart';
import 'package:app/features/file_explorer/user_cases/create_new_directory_use_case.dart';
import 'package:app/features/file_explorer/user_cases/upload_file_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'file_explorer_state.dart';

class FileExplorerCubit extends Cubit<FileExplorerState> {
  FileExplorerCubit(
    this._path,
    this._viewModeCubit,
    this._getDirectoryItemsUseCase,
    this._uploadFileUseCase,
    this._downloadFileUseCase,
    this._renameFileUseCase,
    this._createNewDirectoryUseCase,
    this._deleteFileUseCase,
  ) : super(const FileExplorerInitialState());

  final String _path;
  final ViewModeCubit _viewModeCubit;
  final GetDirectoryItemsUseCase _getDirectoryItemsUseCase;
  final UploadFileUseCase _uploadFileUseCase;
  final DownloadFileUseCase _downloadFileUseCase;
  final RenameFileUseCase _renameFileUseCase;
  final CreateNewDirectoryUseCase _createNewDirectoryUseCase;
  final DeleteFileUseCase _deleteFileUseCase;

  Future<void> fetch() async {
    emit(const FetchingDataFileExplorerState());

    try {
      final files = await _getDirectoryItemsUseCase.invoke(_path) ?? [];

      if (_viewModeCubit.state == ViewMode.list) {
        emit(
          FetchedDataFileExplorerState(
            files..sort((a, b) => a.type.index - b.type.index),
          ),
        );
      } else {
        emit(FetchedDataFileExplorerState(files));
      }
    } catch (exception) {
      emit(
        const FetchingDataErrorFileExplorerState(
          errorMessage: 'Failed to fetch data.',
        ),
      );
    }
  }

  Future<bool> uploadFile(String path, File file) =>
      _uploadFileUseCase.invoke(path, file);

  Future<void> downloadFile(
    String name,
    String pubId, {
    BuildContext? context,
  }) =>
      _downloadFileUseCase.invoke(
        name,
        pubId,
        context: context,
      );

  Future<bool> deleteFile(String pubId) {
    final state = this.state;

    if (state is FetchedDataFileExplorerState) {
      final file = state.files.firstWhere((file) => file.id == pubId);

      return _deleteFileUseCase.invoke(file);
    }

    return Future.value(false);
  }

  Future<bool> renameFile(
    String containingDirectoryPath,
    String newName,
    String pubId,
  ) =>
      _renameFileUseCase.invoke(
        containingDirectoryPath,
        newName,
        pubId,
      );

  Future<bool> createDirectory(String path, String name) =>
      _createNewDirectoryUseCase.invoke(path, name);

  Future<bool> isNameTaken(String path, String name) async {
    final state = this.state;

    if (state is FetchedDataFileExplorerState) {
      return state.files.any((file) => file.title == name);
    } else {
      return true;
    }
  }
}
