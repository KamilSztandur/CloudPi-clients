import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SharePopupResult {
  const SharePopupResult({
    required this.username,
    required this.allowModification,
  });

  final String username;
  final bool allowModification;
}

Future<SharePopupResult?> showSharePopup(BuildContext context) {
  return showDialog<SharePopupResult?>(
    context: context,
    builder: (context) => const _SharePopup(),
  );
}

class _SharePopup extends StatefulWidget {
  const _SharePopup({Key? key}) : super(key: key);

  @override
  State<_SharePopup> createState() => __SharePopupState();
}

class __SharePopupState extends State<_SharePopup> {
  final _controller = TextEditingController();
  var _allowModification = true;
  String? _warningMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _getTitle(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHintLabel(),
          const SizedBox(height: 20),
          _getInputField(),
          _getAllowModificationCheckbox(),
          const SizedBox(height: 5),
          if (_warningMessage != null) _getWarningLabel(),
        ],
      ),
      actions: [
        _getShareButton(),
        _getCancelButton(),
      ],
    );
  }

  Widget _getAllowModificationCheckbox() {
    return CheckboxListTile(
      value: _allowModification,
      contentPadding: EdgeInsets.zero,
      activeColor: Theme.of(context).primaryColor,
      dense: true,
      title: const Text('Allow modification', style: TextStyle(fontSize: 13)),
      onChanged: (value) => setState(() => _allowModification = value ?? false),
    );
  }

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

  Widget _getTitle() => Text(
        'Share content',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold,
        ),
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
        'Enter username of someone you want to share this content with.',
        style: TextStyle(fontSize: 13),
        textAlign: TextAlign.center,
      );

  Widget _getShareButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onShare,
          child: const Text('Share'),
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

  void _onShare() {
    final inputUsername = _controller.text;

    if (_isUsernameValid(inputUsername)) {
      Navigator.of(context).pop(
        SharePopupResult(
          username: _controller.text,
          allowModification: _allowModification,
        ),
      );
    }
  }

  bool _isUsernameValid(String? inputUsername) {
    if (inputUsername == null || inputUsername.isEmpty) {
      setState(() {
        _warningMessage = 'Enter username before submitting.';
      });

      return false;
    } else if (!RegExp('^[a-zA-Z]').hasMatch(inputUsername)) {
      setState(() {
        _warningMessage =
            'Invalid username. It should consist only of letters.';
      });

      return false;
    } else if (inputUsername.contains(' ')) {
      setState(() {
        _warningMessage =
            'Invalid username. It should not contain any white characters';
      });

      return false;
    } else {
      setState(() {
        _warningMessage = null;
      });

      return true;
    }
  }

  void _close() => AutoRouter.of(context).pop();
}
