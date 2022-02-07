import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_error.dart';
import 'package:app/features/loading_baner/presentation/loading_panel.dart';
import 'package:app/features/media_reader/bloc/media_reader_bloc.dart';
import 'package:app/features/media_reader/presentation/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaReaderPage extends StatefulWidget {
  const MediaReaderPage({
    Key? key,
    required this.path,
    required this.resourceName,
  }) : super(key: key);

  final String path;
  final String resourceName;

  @override
  _MediaReaderPageState createState() => _MediaReaderPageState();
}

class _MediaReaderPageState extends State<MediaReaderPage> {
  late MediaReaderBloc _bloc;

  @override
  void initState() {
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

                  return ImagePreview(resourceBytes: resourceBytes);
                } else if (state is MediaDownloadFailureState) {
                  return const FileExplorerErrorWidget(
                    errorMessage: 'Check your internet connection.',
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

  void _mediaReaderBlocListener(BuildContext ctx, MediaReaderState state) =>
      setState(() {});

  Uri _generateUriForResource() => Uri(path: widget.path + widget.resourceName);

  void _initializeBloc() {
    _bloc = MediaReaderBloc();

    final resourceURI = _generateUriForResource();
    _bloc.add(RequestMediaDownloadEvent(resource: resourceURI));
  }
}
