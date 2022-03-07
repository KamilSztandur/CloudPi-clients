import 'package:app/features/search_page/data/models/filters_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeChoice extends StatefulWidget {
  const DateRangeChoice({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final FiltersSettingsModel settings;

  @override
  _DateRangeChoiceState createState() => _DateRangeChoiceState();
}

class _DateRangeChoiceState extends State<DateRangeChoice> {
  final DateTime minPossibleDate = DateTime(2000);
  final DateTime maxPossibleDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Icon(Icons.date_range)),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: _getMinDateWidget(),
          ),
          const Flexible(
            flex: 4,
            child: Icon(Icons.arrow_right_alt_outlined),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: _getMaxDateWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getMinDateWidget() => GestureDetector(
        onTap: _pickMinDate,
        child: Text(
          _getMinDayText(),
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black),
        ),
      );

  Widget _getMaxDateWidget() => GestureDetector(
        onTap: _pickMaxDate,
        child: Text(
          _getMaxDayText(),
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.black),
        ),
      );

  String _getMaxDayText() {
    final selectedDate = widget.settings.maxDate!;
    final now = DateTime.now();

    if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      return 'Now';
    } else {
      return _getFormattedDateText(selectedDate);
    }
  }

  String _getMinDayText() {
    final selectedDate = widget.settings.minDate!;
    final defaultDate = FiltersSettingsModel.withDefaultSettings().minDate!;

    if (selectedDate.year == defaultDate.year &&
        selectedDate.month == defaultDate.month &&
        selectedDate.day == defaultDate.day) {
      return 'Always';
    } else {
      return _getFormattedDateText(selectedDate);
    }
  }

  String _getFormattedDateText(DateTime date) =>
      DateFormat('dd.MM.yyyy').format(date);

  Future<void> _pickMinDate() async {
    final minDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: widget.settings.minDate!,
        firstDate: minPossibleDate,
        lastDate: widget.settings.maxDate!,
      ),
    );

    if (minDate != null) {
      setState(() {
        widget.settings.minDate = minDate;
      });
    }
  }

  Future<void> _pickMaxDate() async {
    final maxDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: widget.settings.maxDate!,
        firstDate: widget.settings.minDate!,
        lastDate: maxPossibleDate,
      ),
    );

    if (maxDate != null) {
      setState(() {
        widget.settings.maxDate = maxDate;
      });
    }
  }

  void _clearMaxDate() => setState(() {
        widget.settings.maxDate = maxPossibleDate;
      });

  void _clearMinDate() => setState(() {
        widget.settings.minDate = minPossibleDate;
      });
}
