import 'package:flutter/material.dart';
import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';

class LibrariesPage extends StatefulWidget {
  LibrariesPage({
    Key? key,
  }) : super(key: key);

  @override
  _LibrariesPageState createState() => _LibrariesPageState();
}

class _LibrariesPageState extends State<LibrariesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(),
      body: UnderConstructionInfo(),
    );
  }
}
