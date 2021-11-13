import 'package:app/features/cached_image/presentation/backup_display.dart';
import 'package:app/features/cached_image/presentation/image_placeholder.dart';
import 'package:flutter/material.dart';

class BackendCachedImage extends StatefulWidget {
  final String url;
  final int? customHeight, customWidth;

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
  Image? image;
  bool? _isImageFetched;

  @override
  void initState() {
    if (this.image == null) {
      _initializeImage();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isImageFetched == true
          ? image
          : ImagePlaceholder(
              height: widget.customHeight,
              width: widget.customWidth,
            ),
    );
  }

  void _initializeImage() {
    this._isImageFetched = false;

    this.image = Image.network(
      widget.url,
      errorBuilder: (BuildContext context, Object exception, StackTrace? st) {
        return BackupDisplay(
          height: widget.customHeight,
          width: widget.customWidth,
        );
      },
    );

    this.image!.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          if (mounted) setState(() => _isImageFetched = true);
        },
      ),
    );
  }
}
