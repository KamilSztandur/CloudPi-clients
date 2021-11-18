import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateDirectoryButton extends SpeedDialChild {
  final Function(String) onSubmitted;
  final BuildContext context;

  CreateDirectoryButton({
    required this.onSubmitted,
    required this.context,
  }) : super(
          child: Icon(Icons.create_new_folder),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Create new directory',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => _CreateDirectoryPopup(
            namePicked: onSubmitted,
            context: context,
          ).show(),
        );
}

class _CreateDirectoryPopup {
  final Function(String) namePicked;
  final BuildContext context;
  final TextEditingController _controller = TextEditingController();
  String? _warningMessage;

  _CreateDirectoryPopup({
    required this.namePicked,
    required this.context,
  });

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: _getTitle(),
            content: Wrap(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _getHintLabel(),
                      SizedBox(height: 20.0),
                      _getInputField(),
                      SizedBox(height: 5.0),
                      if (this._warningMessage != null) _getWarningLabel(),
                      SizedBox(height: 20.0),
                      _getCreateButton(setState),
                      _getCancelButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getTitle() => Text(
        "Create new directory",
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _getInputField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Name",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 15.0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              top: 10.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: TextFormField(
              controller: this._controller,
              decoration: InputDecoration.collapsed(
                hintText: 'Enter name here...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      );

  Widget _getWarningLabel() => Text(
        this._warningMessage ?? "",
        style: TextStyle(color: Colors.red, fontSize: 13.0),
        textAlign: TextAlign.center,
      );

  Widget _getHintLabel() => Text(
        "Name should be unique and not contain any forbidden special characters like #, %, &, {, }, \\, /, *, ?, +, @ etc.",
        style: TextStyle(fontSize: 13.0),
        textAlign: TextAlign.left,
      );

  Widget _getCreateButton(Function setState) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _onCreatePressed(setState),
          child: Text("Create"),
        ),
      );

  Widget _getCancelButton() => Center(
        child: TextButton(
          onPressed: _close,
          child: Text("Cancel", textAlign: TextAlign.center),
        ),
      );

  void _onCreatePressed(Function setState) {
    NewMediaWizard wizard = NewMediaWizard();
    String name = this._controller.text;

    if (wizard.isNameLegal(name)) {
      if (wizard.isDirectoryNameTaken(name)) {
        setState(() {
          this._warningMessage = "Directory with this name already exists.";
        });
      } else {
        this.namePicked(name);
        _close();
      }
    } else {
      setState(() {
        this._warningMessage = "Forbidden name.";
      });
    }
  }

  void _close() => AutoRouter.of(context).pop();
}
