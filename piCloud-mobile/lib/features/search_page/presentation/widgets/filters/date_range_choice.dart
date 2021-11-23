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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _pickMinDate,
                child: Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(width: 5),
                    Text(
                      _getMinDayText(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_right_alt_outlined),
              GestureDetector(
                onTap: _pickMaxDate,
                child: Row(
                  children: [
                    Text(
                      _getMaxDayText(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.date_range),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: _clearDateRange,
              child: const Text(
                'Clear date range',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMaxDayText() {
    final selectedDate = widget.settings.max!;
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
    final selectedDate = widget.settings.min!;
    final defaultDate = FiltersSettingsModel.withDefaultSettings().min!;

    if (selectedDate.year == defaultDate.year &&
        selectedDate.month == defaultDate.month &&
        selectedDate.day == defaultDate.day) {
      return 'Always';
    } else {
      return _getFormattedDateText(selectedDate);
    }
  }

  String _getFormattedDateText(DateTime date) =>
      DateFormat('d.M.y').format(date);

  Future<void> _pickMinDate() async {
    final minDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: widget.settings.min!,
        firstDate: minPossibleDate,
        lastDate: widget.settings.max!,
      ),
    );

    if (minDate != null) {
      setState(() {
        widget.settings.min = minDate;
      });
    }
  }

  Future<void> _pickMaxDate() async {
    final maxDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => DatePickerDialog(
        initialDate: widget.settings.max!,
        firstDate: widget.settings.min!,
        lastDate: maxPossibleDate,
      ),
    );

    if (maxDate != null) {
      setState(() {
        widget.settings.max = maxDate;
      });
    }
  }

  void _clearDateRange() => setState(() {
        widget.settings
          ..min = minPossibleDate
          ..max = maxPossibleDate;
      });
}
