import 'package:app/features/cached_image/presentation/backup_display.dart';
import 'package:app/features/cached_image/presentation/image_placeholder.dart';
import 'package:flutter/material.dart';

class BackendCachedImage extends StatefulWidget {
  const BackendCachedImage({
    Key? key,
    required this.url,
    this.customHeight,
    this.customWidth,
  }) : super(key: key);

  final String url;
  final int? customHeight, customWidth;

  @override
  _BackendCachedImageState createState() => _BackendCachedImageState();
}

class _BackendCachedImageState extends State<BackendCachedImage> {
  Image? image;
  bool? _isImageFetched;

  @override
  void initState() {
    if (image == null) {
      _initializeImage();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isImageFetched ?? false
          ? image
          : ImagePlaceholder(
              height: widget.customHeight,
              width: widget.customWidth,
            ),
    );
  }

  void _initializeImage() {
    _isImageFetched = false;

    image = Image.network(
      widget.url,
      errorBuilder: (context, exception, st) {
        return BackupDisplay(
          height: widget.customHeight,
          width: widget.customWidth,
        );
      },
    );

    image!.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          if (mounted) {
            setState(() => _isImageFetched = true);
          }
        },
      ),
    );
  }
}
