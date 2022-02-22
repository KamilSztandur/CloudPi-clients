import 'dart:typed_data';

import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/media_reader/bloc/media_reader_bloc.dart';
import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:app/features/media_reader/data/media_reader_supported_types.dart';
import 'package:app/features/media_reader/presentation/widgets/image_preview.dart';
import 'package:app/features/media_reader/presentation/widgets/no_preview_available.dart';
import 'package:app/features/media_reader/presentation/widgets/txt_preview.dart';
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
  late MediaReaderService service;

  @override
  void initState() {
    service = MediaReaderService(
      context.read<AuthManager>(),
    );

    _initializeBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreviewAppBar(resourceName: widget.resourceName),
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
    final type = service.defineMediaType(widget.resourceName);

    switch (type) {
      case MediaReaderSupportedTypes.image:
        return ImagePreview(resourceBytes: resourceBytes);

      case MediaReaderSupportedTypes.txt:
        return TextPreview(resourceBytes: resourceBytes);

      default:
        return NoPreviewAvailable(
          path: widget.path,
          resourceName: widget.resourceName,
        );
    }
  }

  void _mediaReaderBlocListener(BuildContext ctx, MediaReaderState state) =>
      setState(() {});

  void _initializeBloc() {
    _bloc = MediaReaderBloc(service);

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
