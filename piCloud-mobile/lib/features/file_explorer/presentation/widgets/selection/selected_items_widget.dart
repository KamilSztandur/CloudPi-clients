import 'package:flutter/material.dart';

class SelectedItemsInfo extends StatelessWidget {
  const SelectedItemsInfo({
    Key? key,
    required this.selectedItemsAmount,
  }) : super(key: key);

  final int selectedItemsAmount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;

    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-1, -1),
            blurRadius: 15,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          'Selected $selectedItemsAmount items.',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
