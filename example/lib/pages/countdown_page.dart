import 'package:flutter/material.dart';
import 'package:flutter_extensionz/flutter_extensionz.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  static const Duration _defaultDuration = Duration(days: 2);
  static final DateTime _defaultDateTime = DateTime.now().add(_defaultDuration);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Countdown.rectangle(
            target: DateTime.now().add(const Duration(seconds: 10)),
          ),
          Countdown.rectangle(
            target: _defaultDateTime,
            backgroundColor: Colors.black,
          ),
          Countdown.rectangle(
            target: _defaultDateTime,
            backgroundColor: Colors.red,
            textColor: Colors.green,
            daysLabel: const Text('D'),
            hoursLabel: const Text('H'),
            minutesLabel: const Text('M'),
            secondsLabel: const Text('S'),
            separator: const Text('♠'),
          ),
          Countdown.rectangle(
            target: _defaultDateTime,
            backgroundColor: Colors.yellow,
            daysLabel: const Icon(Icons.calendar_today),
            hoursLabel: const Icon(Icons.hourglass_empty),
            minutesLabel: const Icon(Icons.av_timer),
            secondsLabel: const Icon(Icons.autofps_select),
            separator: const Text('☻'),
          ),
          Countdown.circle(
            target: _defaultDateTime,
          ),
          Countdown(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25),
            ),
            separator: const Text(
              '~',
              style: TextStyle(
                color: Colors.lime,
              ),
            ),
            target: _defaultDateTime,
            textColor: Colors.blue.complimentary,
          ),
        ],
      ),
    );
  }
}
