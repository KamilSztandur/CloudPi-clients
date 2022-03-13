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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share...'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Allow modification'),
            value: _allowModification,
            onChanged: (value) => setState(
              () => _allowModification = value ?? false,
            ),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'with'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Share'),
          onPressed: () => Navigator.of(context).pop(
            SharePopupResult(
              username: _controller.text,
              allowModification: _allowModification,
            ),
          ),
        ),
      ],
    );
  }
}
