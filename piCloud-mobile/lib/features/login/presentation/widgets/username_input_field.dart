import 'package:flutter/material.dart';

class UsernameInputField extends StatelessWidget {
  UsernameInputField({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    required this.defaultValue,
  }) : super(key: key);

  final Function(String) onChanged;
  final TextEditingController _controller = TextEditingController();
  final VoidCallback onSubmitted;
  final String? defaultValue;

  @override
  Widget build(BuildContext context) {
    if (defaultValue != null) {
      _controller.text = defaultValue!;
    }

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
            'Username',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
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
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _controller,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.black87),
              onSubmitted: (value) => onSubmitted(),
              decoration: const InputDecoration(
                hintText: 'Username',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
