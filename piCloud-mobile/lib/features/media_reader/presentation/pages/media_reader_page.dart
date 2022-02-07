import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/preview_app_bar.dart';
import 'package:flutter/material.dart';

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
  final String title = 'MediaReader';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreviewAppBar(resourceName: widget.resourceName),
      body: UnderConstructionInfo(pageName: title),
    );
  }
}
