import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/status_popups/rename_file.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
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
  }) : super(key: key);

  final String path;
  final String resourceName;
  final String? resourcePubId;

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
    return Scaffold(
      appBar: PreviewAppBar(
        resourceName: widget.resourceName,
        onShareRequested: _onShareRequested,
        onDeleteRequested: _onDeleteRequested,
        onDownloadRequested: _onDownloadRequested,
        onRenameRequested: _onRenameRequested,
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
                  return const FileExplorerErrorWidget(
                    errorMessage: 'Check your internet connection.',
                  );
                } else if (state is MediaFileDamagedState) {
                  return const FileExplorerErrorWidget(
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

  void _onDownloadRequested() => _service.downloadMediaToDevice(
        widget.resourceName,
        widget.resourcePubId ?? '',
      );

  void _onRenameRequested() => RenameFilePopup(
        context: context,
        currentName: widget.resourceName,
        currentPath: widget.path,
        resourceId: widget.resourcePubId!,
      ).show();

  Future<void> _onDeleteRequested() async {
    final isSuccessful = await _directoryManager.deleteFile(
      widget.resourcePubId!,
    );

    var message = '';
    if (isSuccessful) {
      message = '${widget.resourceName} deleted.';

      await AutoRouter.of(context).pop();
    } else {
      message = 'Failed to delete ${widget.resourceName}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message),
      ),
    );
  }

  void _onShareRequested() {
    //TODO
  }

  void _mediaReaderBlocListener(BuildContext ctx, MediaReaderState state) =>
      setState(() {});

  void _initializeBloc() {
    _bloc = MediaReaderBloc(
      _service,
    );

    if (widget.resourcePubId != null) {
      _bloc.add(
        RequestMediaDownloadEvent(resourcePubId: widget.resourcePubId!),
      );
    } else {
      _bloc.add(
        const DetectedDamagedFileEvent(),
      );
    }
  }
}
