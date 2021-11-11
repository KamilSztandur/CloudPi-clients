import 'package:flutter/material.dart';

class SelectedItemsInfo extends StatelessWidget {
  final int selectedItemsAmount;

  SelectedItemsInfo({
    required this.selectedItemsAmount,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    return Container(
      height: 40.0,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-1, -1),
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Center(
        child: Text(
          "Selected $selectedItemsAmount items.",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
