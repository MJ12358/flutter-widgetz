// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PollPage extends StatelessWidget {
  const PollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Poll(
            borderRadius: 16.0,
            endDate: DateTime.now().add(const Duration(seconds: 10)),
            question: 'What is your favorite color?',
            spacing: 8.0,
            options: <PollOption>[
              PollOption(id: '1', name: 'Amber', votes: 1),
              PollOption(id: '2', name: 'Blue', votes: 0),
              PollOption(id: '3', name: 'Green', votes: 75),
              PollOption(id: '4', name: 'Purple', votes: 88),
            ],
            onVoted: (PollOption option) async {
              print(option.name);
              print(option.votes);
            },
          ),
          Poll(
            endDate: DateTime.now().add(const Duration(hours: -2)),
            question: 'What is the best dog breed?',
            options: <PollOption>[
              PollOption(id: '1', name: 'German Shepard', votes: 88),
              PollOption(id: '2', name: 'Great Dane', votes: 75),
              PollOption(id: '3', name: 'Corgie', votes: 70),
              PollOption(id: '4', name: 'Golden Retriever', votes: 90),
            ],
            onVoted: (PollOption option) async {
              print(option.name);
              print(option.votes);
            },
          ),
          Poll(
            backgroundColor: Colors.grey,
            borderRadius: 48.0,
            color: Colors.amber,
            endDate: DateTime.now().add(const Duration(minutes: 5)),
            question: 'Is Flutter the best framework for building '
                'cross-platform applications?',
            options: <PollOption>[
              PollOption(id: '1', name: 'Yes', votes: 88),
              PollOption(id: '2', name: 'Maybe', votes: 7),
              PollOption(id: '3', name: 'No', votes: 2),
            ],
            onVoted: (PollOption option) async {
              print(option.name);
              print(option.votes);
            },
          ),
        ],
      ),
    );
  }
}
