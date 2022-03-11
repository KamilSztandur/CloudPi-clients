import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.headerText,
    required this.hintText,
    required this.onChanged,
    this.initialValue,
    required this.isEnabled,
  }) : super(key: key);

  final Function(String) onChanged;
  final TextEditingController _controller = TextEditingController();
  final String headerText;
  final String hintText;
  final String? initialValue;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    _controller.text = initialValue ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColorDark,
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColorDark,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              enabled: isEnabled,
              controller: _controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
