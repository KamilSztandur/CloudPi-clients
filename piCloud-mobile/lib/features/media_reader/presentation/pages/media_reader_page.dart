import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/widgets/error_view.dart';
import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/media_reader/bloc/media_reader_bloc.dart';
import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:app/features/media_reader/presentation/widgets/image_preview.dart';
import 'package:app/features/media_reader/presentation/widgets/no_preview_available.dart';
import 'package:app/features/media_reader/presentation/widgets/txt_preview.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaReaderPage extends StatefulWidget {
  const MediaReaderPage({
    Key? key,
    required this.path,
    required this.resourceName,
    required this.resourcePubId,
    required this.onActionFinalized,
  }) : super(key: key);

  final String path, resourceName;
  final String resourcePubId;
  final VoidCallback onActionFinalized;

  @override
  _MediaReaderPageState createState() => _MediaReaderPageState();
}

class _MediaReaderPageState extends State<MediaReaderPage> {
  late MediaReaderBloc _bloc;
  late MediaReaderService _service;

  @override
  void initState() {
    _service = MediaReaderService(context.read<AuthManager>());
    _initializeBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreviewAppBar(
        resourceName: widget.resourceName,
        onShareRequested: _onShareRequested,
        onDeleteRequested: _onDeleteRequested,
        onDownloadRequested: _onDownloadRequested,
        onRenameRequested: _onRenameRequested,
        onToggleFavoriteRequested: _onToggleFavoriteRequested,
      ),
      body: Center(
        child: BlocProvider.value(
          value: _bloc,
          child: BlocBuilder<MediaReaderBloc, MediaReaderState>(
            builder: (context, state) {
              if (state is MediaDownloadSuccessState) {
                final resourceBytes = state.resourceBytes;
                return _buildPreviewForResourceOfType(resourceBytes);
              } else if (state is MediaDownloadFailureState) {
                return const ErrorView(
                  errorMessage: 'Check your internet connection.',
                );
              } else {
                return const LoadingPanel();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewForResourceOfType(Uint8List resourceBytes) {
    final type = _service.defineMediaType(widget.resourceName);

    switch (type) {
      case MediaReaderSupportedTypes.image:
        return ImagePreview(resourceBytes: resourceBytes);

      case MediaReaderSupportedTypes.txt:
        return TextPreview(resourceBytes: resourceBytes);

      default:
        return NoPreviewAvailable(
          path: widget.path,
          resourceName: widget.resourceName,
          onDownloadRequested: _onDownloadRequested,
        );
    }
  }

  Future<void> _onDownloadRequested() async {
    try {
      await context.read<FileExplorerCubit>().downloadFile(
            widget.resourceName,
            widget.resourcePubId,
            context: context,
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
            '${widget.resourceName} download failed.',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future<void> _onRenameRequested() async {
    await RenameFilePopup(
      context: context,
      currentName: widget.resourceName,
      currentPath: widget.path,
      resourceId: widget.resourcePubId,
      amount: 1,
      groupNamePicked: (name) {},
    ).show();

    widget.onActionFinalized();
  }

  void _onToggleFavoriteRequested() {
    context.read<FavoritesManager>().toggleFavorite([widget.resourcePubId]);
  }

  Future<void> _onDeleteRequested() async {
    final isSuccessful = await context.read<FileExplorerCubit>().deleteFile(
          widget.resourcePubId,
        );

    var message = '';
    if (isSuccessful) {
      message = '${widget.resourceName} deleted.';

      await AutoRouter.of(context).pop();
      widget.onActionFinalized();
    } else {
      message = 'Failed to delete ${widget.resourceName}';
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

  void _onShareRequested() {
    //TODO
  }

  void _initializeBloc() {
    _bloc = MediaReaderBloc(_service);

    _bloc.add(
      RequestMediaDownloadEvent(resourcePubId: widget.resourcePubId),
    );
  }
}
