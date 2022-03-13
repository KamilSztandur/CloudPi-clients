import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/models/file_permission.dart';
import 'package:app/common/widgets/error_view.dart';
import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/details_popup.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/show_share_popup.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/media_reader/bloc/media_reader_bloc.dart';
import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:app/features/media_reader/presentation/widgets/image_preview.dart';
import 'package:app/features/media_reader/presentation/widgets/no_preview_available.dart';
import 'package:app/features/media_reader/presentation/widgets/txt_preview.dart';
import 'package:app/features/shared_page/data/shared_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaReaderPage extends StatefulWidget {
  const MediaReaderPage({
    Key? key,
    required this.path,
    required this.item,
    required this.permissions,
    required this.shared,
    this.onActionFinalized,
  }) : super(key: key);

  final String path;
  final FileItem item;
  final Set<FilePermission> permissions;
  final bool shared;
  final VoidCallback? onActionFinalized;

  @override
  _MediaReaderPageState createState() => _MediaReaderPageState();
}

class _MediaReaderPageState extends State<MediaReaderPage> {
  late MediaReaderBloc _bloc;
  late MediaReaderService _service;
  late DirectoryManager _directoryManager;

  @override
  void initState() {
    _service = MediaReaderService(context.read<AuthManager>());
    _directoryManager = context.read<DirectoryManager>();
    _initializeBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final canModify = widget.permissions.contains(FilePermission.modify);

    return Scaffold(
      appBar: PreviewAppBar(
        resourceName: widget.item.title,
        onDetailsRequested: _onDetailsRequested,
        onDownloadRequested: _onDownloadRequested,
        onShareRequested:
            !widget.shared ? () => _onShareRequested(context) : null,
        onDeleteRequested: canModify ? _onDeleteRequested : null,
        onRenameRequested: canModify ? _onRenameRequested : null,
        onToggleFavoriteRequested:
            !widget.shared ? _onToggleFavoriteRequested : null,
      ),
      body: Center(
        child: BlocProvider.value(
          value: _bloc,
          child: BlocListener<MediaReaderBloc, MediaReaderState>(
            listener: _mediaReaderBlocListener,
            child: BlocBuilder<MediaReaderBloc, MediaReaderState>(
              builder: (context, state) {
                if (state is MediaDownloadSuccessState) {
                  final resourceBytes = state.resourceBytes;
                  return _buildPreviewForResourceOfType(resourceBytes);
                } else if (state is MediaDownloadFailureState) {
                  return const ErrorView(
                    errorMessage: 'Check your internet connection.',
                  );
                } else if (state is MediaFileDamagedState) {
                  return const ErrorView(
                    errorMessage: 'File is damaged. Contact administrator.',
                  );
                } else {
                  return const LoadingPanel();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewForResourceOfType(Uint8List resourceBytes) {
    final type = _service.defineMediaType(widget.item.title);

    switch (type) {
      case MediaReaderSupportedTypes.image:
        return ImagePreview(resourceBytes: resourceBytes);

      case MediaReaderSupportedTypes.txt:
        return TextPreview(resourceBytes: resourceBytes);

      default:
        return NoPreviewAvailable(
          path: widget.path,
          resourceName: widget.item.title,
          onDownloadRequested: _onDownloadRequested,
        );
    }
  }

  Future<void> _onDownloadRequested() async {
    try {
      await _directoryManager.downloadMediaToDevice(
        widget.item.title,
        widget.item.id ?? '',
        context: context,
        setState: setState,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text(
            'Download completed.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            '${widget.item.title} download failed.',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future<void> _onRenameRequested() async {
    await RenameFilePopup(
      context: context,
      currentName: widget.item.title,
      currentPath: widget.path,
      resourceId: widget.item.id!,
      amount: 1,
      groupNamePicked: (name) {},
    ).show();

    widget.onActionFinalized?.call();
  }

  void _onToggleFavoriteRequested() {
    context.read<FavoritesManager>().toggleFavorite([widget.item.id!]);
  }

  Future<void> _onDetailsRequested() async => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          title: Text(widget.item.title),
          content: DetailsView(
            item: widget.item,
            path: widget.path,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      );

  Future<void> _onDeleteRequested() async {
    final isSuccessful = await _directoryManager.deleteFile(
      widget.item.id!,
    );

    var message = '';
    if (isSuccessful) {
      message = '${widget.item.title} deleted.';

      await AutoRouter.of(context).pop();
      widget.onActionFinalized?.call();
    } else {
      message = 'Failed to delete ${widget.item.title}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _onShareRequested(BuildContext context) async {
    final sharePopupResult = await showSharePopup(context);

    if (sharePopupResult != null) {
      final username = sharePopupResult.username;
      final result = await context.read<SharedManager>().shareFiles(
        pubIds: [widget.item.id!],
        userName: sharePopupResult.username,
        allowModification: sharePopupResult.allowModification,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            result
                ? 'Shared successfully with $username'
                : 'Failed to share this content with $username. Check if this username is valid.',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  void _mediaReaderBlocListener(BuildContext ctx, MediaReaderState state) =>
      setState(() {});

  void _initializeBloc() {
    _bloc = MediaReaderBloc(
      _service,
    );

    if (widget.item.id != null) {
      _bloc.add(
        RequestMediaDownloadEvent(resourcePubId: widget.item.id!),
      );
    } else {
      _bloc.add(
        const DetectedDamagedFileEvent(),
      );
    }
  }
}
