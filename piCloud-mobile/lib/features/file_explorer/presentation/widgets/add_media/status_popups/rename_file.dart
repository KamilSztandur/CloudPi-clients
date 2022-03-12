import 'package:app/features/file_explorer/bloc/file_explorer_cubit.dart';
import 'package:app/features/file_explorer/data/new_media_wizard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenameFilePopup {
  RenameFilePopup({
    required this.context,
    required this.currentName,
    required this.currentPath,
    required this.resourceId,
    required this.amount,
    required this.groupNamePicked,
  });

  final BuildContext context;
  final String currentName, currentPath, resourceId;
  final int amount;

  final Function(String) groupNamePicked;

  final TextEditingController _controller = TextEditingController();
  String? _warningMessage;

  Future<void> show() {
    return showDialog<void>(
      context: context,
      builder: (context) {
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
                    _getRenameButton(setState),
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

  Future<void> showGroupRename() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            contentPadding: const EdgeInsets.only(
              top: 15,
              right: 15,
              left: 15,
            ),
            title: Text(
              'Rename $amount items',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    _getGroupRenameButton(setState),
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
        'Rename $currentName',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColorDark,
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
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColorDark,
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

  Widget _getRenameButton(void Function(void Function()) setState) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _onRenamePressed(setState),
          child: const Text('Rename'),
        ),
      );

  Widget _getGroupRenameButton(
    void Function(void Function()) setState,
  ) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _onGroupRenamePressed(setState),
          child: const Text('Rename all'),
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

  Future<void> _onGroupRenamePressed(
    void Function(void Function()) setState,
  ) async {
    final wizard = NewMediaWizard(context.read<FileExplorerCubit>());
    final newName = _controller.text;

    if (wizard.isFilenameLegal(newName)) {
      if (await wizard.isNameTaken(currentPath, newName)) {
        setState(
          () {
            _warningMessage = 'Item with this name already exists.';
          },
        );
      } else {
        _close();
        groupNamePicked(newName);
      }
    } else {
      setState(
        () {
          _warningMessage = 'Forbidden name.';
        },
      );
    }
  }

  Future<void> _onRenamePressed(void Function(void Function()) setState) async {
    final wizard = NewMediaWizard(context.read<FileExplorerCubit>());
    final newName = _controller.text;

    if (wizard.isFilenameLegal(newName)) {
      if (await wizard.isNameTaken(currentPath, newName)) {
        setState(
          () {
            _warningMessage = 'Item with this name already exists.';
          },
        );
      } else {
        _close();
      }
    } else {
      setState(
        () {
          _warningMessage = 'Forbidden name.';
        },
      );
    }

    final isSuccessful = await context.read<FileExplorerCubit>().renameFile(
          currentPath,
          newName,
          resourceId,
        );

    var message = '';
    if (isSuccessful) {
      message = '$currentName renamed to $newName.';

      await AutoRouter.of(context).pop();
    } else {
      message = 'Failed to rename $currentName.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _close() => AutoRouter.of(context).pop();
}
