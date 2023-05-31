import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  static const Duration _defaultDuration = Duration(days: 1);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Countdown(
            target: DateTime.now().add(_defaultDuration),
          ),
          Countdown(
            target: DateTime(2023, 6),
            backgroundColor: Colors.black,
          ),
          Countdown(
            target: DateTime(2023, 6),
            backgroundColor: Colors.red,
            textColor: Colors.green,
            daysText: 'D',
            hoursText: 'H',
            minutesText: 'M',
            secondsText: 'S',
          ),
          Countdown(
            target: DateTime(2023, 6),
            backgroundColor: Colors.yellow,
            daysLabel: const Icon(Icons.calendar_today),
            hoursLabel: const Icon(Icons.hourglass_empty),
            minutesLabel: const Icon(Icons.av_timer),
            secondsLabel: const Icon(Icons.autofps_select),
          ),
          Countdown(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            target: DateTime.now().add(_defaultDuration),
          ),
          Countdown.circular(
            target: DateTime.now().add(_defaultDuration),
          )
        ],
      ),
    );
  }
}
