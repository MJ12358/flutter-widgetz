// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isSaving = false;
  DownloadStatus _downloadStatus = DownloadStatus.initial;
  double _downloadProgress = 0.0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CustomDivider(
            child: Text('Elevated Buttons'),
          ),
          CustomElevatedButton(
            onPressed: () => print('button one pressed'),
            child: const Text('Button One'),
          ),
          CustomElevatedButton(
            onPressed: () => print('button two pressed'),
            child: const Text('Button Two'),
          ),
          CustomElevatedButton(
            onPressed: () => print('button three pressed'),
            color: Colors.yellow,
            child: const Text('Button Three'),
          ),
          CustomElevatedButton(
            onPressed: () => print('button four pressed'),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Text('Button Four'),
          ),
          CustomElevatedButton(
            onPressed: () => print('button five pressed'),
            color: Theme.of(context).colorScheme.onSurface,
            child: const Text('Button Five'),
          ),
          const CustomDivider(
            child: Text('Save Button'),
          ),
          SaveButton(
            onPressed: _onSaveButtonPressed,
            isSaving: _isSaving,
          ),
          const CustomDivider(
            child: Text('Factories'),
          ),
          Button(
            color: Colors.black,
            onPressed: () => print('button'),
            child: const Text('Button'),
          ),
          Button.brand(
            onPressed: () => print('brand'),
            child: const Text('Brand'),
          ),
          Button.destructive(
            onPressed: () => print('destructive'),
            child: const Text('Destructive'),
          ),
          Button.inverse(
            onPressed: () => print('inverse'),
            child: const Text('Inverse'),
          ),
          Button.neutral(
            onPressed: () => print('neutral'),
            child: const Text('Neutral'),
          ),
          Button.outline(
            onPressed: () => print('outline1'),
            child: const Text('Outline One'),
          ),
          Button.outline(
            color: Colors.purple,
            onPressed: () => print('outline2'),
            child: const Text('Outline Two'),
          ),
          const CustomDivider(
            child: Text('Constrained Box'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Button.success(
              onPressed: () => print('success'),
              child: const Text('Success'),
            ),
          ),
          const CustomDivider(
            child: Text('Download Button'),
          ),
          DownloadButton(
            // primaryColor: Colors.purple,
            // secondaryColor: Colors.black,
            status: _downloadStatus,
            progress: _downloadProgress,
            onDownload: _onDownloadButtonPressed,
            onCancel: () => print('onCancel'),
            onOpen: () => print('onOpen'),
          ),
        ],
      ),
    );
  }

  /// This is used to simulate a saving event.
  Future<void> _onSaveButtonPressed() async {
    setState(() {
      _isSaving = !_isSaving;
    });
    await Future<void>.delayed(const Duration(seconds: 3));
    setState(() {
      _isSaving = !_isSaving;
    });
  }

  /// This is used to simulate a download event.
  Future<void> _onDownloadButtonPressed() async {
    setState(() {
      _downloadStatus = DownloadStatus.fetching;
    });
    Future<void>.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        _downloadStatus = DownloadStatus.downloading;
      }),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final double progress = timer.tick / 5;
      setState(() {
        _downloadProgress = progress;
      });
      if (progress >= 1) {
        setState(() {
          _downloadStatus = DownloadStatus.done;
        });
        timer.cancel();
      }
    });
  }
}
