import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateDirectoryPopup {
  CreateDirectoryPopup({
    required this.namePicked,
    required this.context,
  });

  final Function(String) namePicked;
  final BuildContext context;
  final TextEditingController _controller = TextEditingController();
  String? _warningMessage;

  void show() {
    showDialog<void>(
      context: context,
      builder: (context) {
        // return alert dialog object
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            contentPadding: const EdgeInsets.only(
              top: 15,
              right: 15,
              left: 15,
            ),
            title: _getTitle(),
            content: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getHintLabel(),
                    const SizedBox(height: 20),
                    _getInputField(),
                    const SizedBox(height: 5),
                    if (_warningMessage != null) _getWarningLabel(),
                    const SizedBox(height: 20),
                    _getCreateButton(setState),
                    _getCancelButton(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getTitle() => Text(
        'Create new directory',
        textAlign: TextAlign.center,
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
            'Name',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 15,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter name here...',
              ),
            ),
          ),
        ],
      );

  Widget _getWarningLabel() => Text(
        _warningMessage ?? '',
        style: const TextStyle(
          color: Colors.red,
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      );

  Widget _getHintLabel() => const Text(
        r'Name should be unique and not contain any forbidden special characters like #, %, &, {, }, \, /, *, ?, +, @ etc.',
        style: TextStyle(fontSize: 13),
        textAlign: TextAlign.center,
      );

  Widget _getCreateButton(void Function(void Function()) setState) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _onCreatePressed(setState),
          child: const Text('Create'),
        ),
      );

  Widget _getCancelButton() => Center(
        child: TextButton(
          onPressed: _close,
          child: const Text(
            'Cancel',
            textAlign: TextAlign.center,
          ),
        ),
      );

  void _onCreatePressed(void Function(void Function()) setState) {
    final wizard = NewMediaWizard();
    final name = _controller.text;

    if (wizard.isNameLegal(name)) {
      if (wizard.isDirectoryNameTaken(name)) {
        setState(
          () {
            _warningMessage = 'Directory with this name already exists.';
          },
        );
      } else {
        namePicked(name);
        _close();
      }
    } else {
      setState(
        () {
          _warningMessage = 'Forbidden name.';
        },
      );
    }
  }

  void _close() => AutoRouter.of(context).pop();
}
