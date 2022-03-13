import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    Key? key,
    required this.onPasswordChanged,
    required this.onSubmitted,
  }) : super(key: key);

  final Function(String) onPasswordChanged;
  final VoidCallback onSubmitted;

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _visible = true;

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
            'Password',
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
              obscureText: _visible,
              onChanged: _onChanged,
              onSubmitted: (value) => widget.onSubmitted(),
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: 'Password',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _visible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = !_visible;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onChanged(String value) {
    setState(() {
      widget.onPasswordChanged(value);
    });
  }
}
