import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_add_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_view.dart';
import 'package:flutter/material.dart';

class FileExplorerPage extends StatefulWidget {
  FileExplorerPage({
    Key? key,
  }) : super(key: key);

  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(height: 50.0),
      body: FileExplorerView(path: 'blablablabla'),
      floatingActionButton: AddMediaButton(),
    );
  }
}
