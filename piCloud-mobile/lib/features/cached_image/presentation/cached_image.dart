import 'package:app/features/cached_image/bloc/cached_image_bloc.dart';
import 'package:app/features/cached_image/presentation/backup_display.dart';
import 'package:app/features/cached_image/presentation/image_placeholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BackendCachedImage extends StatefulWidget {
  final String url;
  int? customHeight, customWidth;

  BackendCachedImage({
    Key? key,
    required this.url,
    this.customHeight,
    this.customWidth,
  }) : super(key: key);

  @override
  _BackendCachedImageState createState() => _BackendCachedImageState();
}

class _BackendCachedImageState extends State<BackendCachedImage> {
  late CachedImageBloc _bloc;

  @override
  void initState() {
    this._bloc = CachedImageBloc(
      url: widget.url,
      height: widget.customHeight,
      width: widget.customWidth,
    );
    this._bloc.add(FetchCachedImageEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider.value(
        value: this._bloc,
        child: BlocListener<CachedImageBloc, CachedImageState>(
          listener: _cachedImageBlocListener,
          child: BlocBuilder<CachedImageBloc, CachedImageState>(
            builder: (context, state) {
              if (state is CachedImageFetchedState) {
                return state.image;
              } else if (state is CachedImageFetchingFailureState) {
                return BackupDisplay(
                  size: (this.widget.customHeight != null)
                      ? this.widget.customHeight!.toDouble()
                      : (this.widget.customWidth != null)
                          ? this.widget.customWidth!.toDouble()
                          : null,
                );
              } else {
                return ImagePlaceholder(
                  height: this.widget.customHeight != null
                      ? this.widget.customHeight!.toDouble()
                      : null,
                  width: this.widget.customWidth != null
                      ? this.widget.customWidth!.toDouble()
                      : null,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _cachedImageBlocListener(BuildContext context, CachedImageState state) {
    setState(() {
      if (state is CachedImageFetchingFailureState) {
        context.read<CachedImageBloc>().add(FetchingCachedImageErrorEvent());
      } else if (state is CachedImageFetchedState) {
        context.read<CachedImageBloc>().add(FetchingCachedImageFinishedEvent());
      }
    });
  }
}
