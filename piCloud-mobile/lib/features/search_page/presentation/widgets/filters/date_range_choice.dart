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
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: _getMinDateWidget(),
          ),
          const Flexible(
            flex: 1,
            child: Icon(Icons.arrow_right_alt_outlined),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: _getMaxDateWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getMinDateWidget() => GestureDetector(
        onTap: _pickMinDate,
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 5),
            Text(
              _getMinDayText(),
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      );

  Widget _getMaxDateWidget() => GestureDetector(
        onTap: _pickMaxDate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _getMaxDayText(),
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.date_range),
          ],
        ),
      );

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
      DateFormat('dd.MM.yyyy').format(date);

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

  void _clearMaxDate() => setState(() {
        widget.settings.max = maxPossibleDate;
      });

  void _clearMinDate() => setState(() {
        widget.settings.min = minPossibleDate;
      });
}
