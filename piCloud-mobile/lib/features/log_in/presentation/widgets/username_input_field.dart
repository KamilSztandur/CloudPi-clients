import 'package:flutter/material.dart';

class UsernameInputField extends StatelessWidget {
  UsernameInputField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(
                hintText: 'Username',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
