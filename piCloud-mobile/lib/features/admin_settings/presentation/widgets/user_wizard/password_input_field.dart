import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

class InputFieldPassword extends StatefulWidget {
  const InputFieldPassword({
    Key? key,
    required this.headerText,
    required this.hintTexti,
    required this.onPasswordChanged,
  }) : super(key: key);

  final String headerText;
  final String hintTexti;
  final Function(String) onPasswordChanged;

  @override
  State<InputFieldPassword> createState() => _InputFieldPasswordState();
}

class _InputFieldPasswordState extends State<InputFieldPassword> {
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
            widget.headerText,
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
              decoration: InputDecoration(
                hintText: widget.hintTexti,
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
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _getPasswordInfo(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _getPasswordColor(),
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

  String _getPasswordInfo() {
    if (_controller.text.isEmpty) {
      return '';
    }

    final strength = estimatePasswordStrength(_controller.text);

    if (strength < 0.33) {
      return 'Very weak password';
    } else if (strength < 0.66) {
      return 'Weak password';
    } else {
      return 'Strong password';
    }
  }

  Color _getPasswordColor() {
    final strength = estimatePasswordStrength(_controller.text);

    if (strength < 0.33) {
      return Colors.red;
    } else if (strength < 0.66) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
