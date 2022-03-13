import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastModifiedOnDateLabel extends StatelessWidget {
  const LastModifiedOnDateLabel({
    Key? key,
    required this.lastModifiedOn,
  }) : super(key: key);

  final DateTime lastModifiedOn;

  @override
  Widget build(BuildContext context) {
    final date = _getProperDateFormat(lastModifiedOn);
    final time = _getProperTimeFormat(lastModifiedOn);

    return Text(
      '$date at $time',
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  String _getProperDateFormat(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  String _getProperTimeFormat(DateTime dateTime) {
    return DateFormat('Hm').format(dateTime);
  }
}
