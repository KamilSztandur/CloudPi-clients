import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/app_bar/selection_app_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_add_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_view.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';

class FileExplorerPage extends StatefulWidget {
  final String path;

  FileExplorerPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> {
  Selection? selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSelecting()
          ? SelectionAppBar(
              selection: this.selection ?? DragSelectGridViewController().value,
            ) as PreferredSizeWidget
          : PICloudAppBar(title: _getTitle()),
      drawer: MainDrawer(),
      body: FileExplorerView(
        path: this.widget.path,
        selectionChanged: (Selection selection) => setState(() {
          this.selection = selection;
        }),
      ),
      floatingActionButton:
          (this.selection != null && this.selection!.amount > 0)
              ? Container()
              : AddMediaButton(),
      bottomNavigationBar: PICloudBottomNavigationBar(),
    );
  }

  bool _isSelecting() {
    if (this.selection != null && this.selection!.amount > 0) {
      return true;
    } else {
      return false;
    }
  }

  String _getTitle() {
    if (widget.path == "/") {
      return "Files";
    } else {
      String directoryName = widget.path.substring(0, widget.path.length - 1);
      directoryName = directoryName.split('/').last;

      return directoryName;
    }
  }
}
