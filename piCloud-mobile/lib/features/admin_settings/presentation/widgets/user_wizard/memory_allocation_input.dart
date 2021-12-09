import 'package:flutter/material.dart';

class MemoryAllocationInput extends StatefulWidget {
  const MemoryAllocationInput({
    Key? key,
    required this.headerText,
    required this.defaultValue,
    required this.onValueChanged,
    required this.maxValue,
  }) : super(key: key);

  final String headerText;
  final double defaultValue, maxValue;
  final Function(double) onValueChanged;

  @override
  _MemoryAlocationState createState() => _MemoryAlocationState();
}

class _MemoryAlocationState extends State<MemoryAllocationInput> {
  late double currentValue;

  @override
  void initState() {
    currentValue = widget.defaultValue;
    super.initState();
  }

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
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  '${currentValue.ceil()} Mb',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 17.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Slider(
                  value: currentValue,
                  max: widget.maxValue,
                  divisions: 100,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });

                    widget.onValueChanged(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
