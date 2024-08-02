part of flutter_widgetz;

enum DownloadStatus {
  /// The initial status of a download.
  initial,

  /// Used to indicate connection status.
  fetching,

  /// Download is in progress.
  downloading,

  /// Download is finished.
  done,
}

/// {@template flutter_widgetz.DownloadButton}
/// A button used to represent the progress of a download.
///
/// The download button's visual presentation is
/// based on the given [status].
///
/// https://docs.flutter.dev/cookbook/effects/download-button
///
///![DownloadButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/download_button1.png)
///
///![DownloadButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/download_button2.png)
///
///![DownloadButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/download_button3.png)
/// {@endtemplate}
class DownloadButton extends StatelessWidget {
  /// {@macro flutter_widgetz.DownloadButton}
  const DownloadButton({
    super.key,
    required this.status,
    required this.onDownload,
    required this.onCancel,
    required this.onOpen,
    required this.progress,
    this.primaryColor = Colors.black12,
    this.secondaryColor = Colors.blue,
    this.initialLabel = const Text('GET'),
    this.doneLabel = const Text('OPEN'),
    this.duration = const Duration(milliseconds: 500),
  });

  /// The current status of the download.
  final DownloadStatus status;

  /// Called when the button is initially pressed.
  final VoidCallback onDownload;

  /// Called when the download is cancelled.
  final VoidCallback onCancel;

  /// Called when the download is opened.
  final VoidCallback onOpen;

  /// The progress of the download.
  final double progress;

  /// The primary color of the button.
  final Color primaryColor;

  /// The secondary color of the button.
  final Color secondaryColor;

  /// The widget used to represent the initial status.
  final Widget initialLabel;

  /// The widget used to represent the done status.
  final Widget doneLabel;

  /// The duration of the transition animations.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: <Widget>[
          _DownloadButtonShape(
            duration: duration,
            isInProgress: status.isInProgress,
            isDone: status.isDone,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            initialLabel: initialLabel,
            doneLabel: doneLabel,
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: duration,
              opacity: status.isInProgress ? 1.0 : 0.0,
              curve: Curves.ease,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _ProgressIndicator(
                    progress: progress,
                    isDownloading: status.isDownloading,
                    isFetching: status.isFetching,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                  ),
                  if (status.isDownloading)
                    Icon(
                      Icons.stop,
                      size: 14,
                      color: secondaryColor,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressed() {
    switch (status) {
      case DownloadStatus.initial:
        onDownload();
      case DownloadStatus.fetching:
        // do nothing.
        break;
      case DownloadStatus.downloading:
        onCancel();
      case DownloadStatus.done:
        onOpen();
    }
  }
}

class _DownloadButtonShape extends StatelessWidget {
  const _DownloadButtonShape({
    required this.duration,
    required this.isInProgress,
    required this.isDone,
    required this.primaryColor,
    required this.secondaryColor,
    required this.initialLabel,
    required this.doneLabel,
  });

  final Duration duration;
  final bool isInProgress;
  final bool isDone;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget initialLabel;
  final Widget doneLabel;

  @override
  Widget build(BuildContext context) {
    ShapeDecoration shape;
    final ThemeData theme = Theme.of(context);

    if (isInProgress) {
      shape = ShapeDecoration(
        shape: const CircleBorder(),
        color: Colors.white.withOpacity(0.0),
      );
    } else {
      shape = ShapeDecoration(
        shape: const StadiumBorder(),
        color: primaryColor,
      );
    }

    return AnimatedContainer(
      duration: duration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: AnimatedOpacity(
          duration: duration,
          opacity: isInProgress ? 0.0 : 1.0,
          curve: Curves.ease,
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
            child: isDone ? doneLabel : initialLabel,
          ),
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.progress,
    required this.isDownloading,
    required this.isFetching,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double progress;
  final bool isDownloading;
  final bool isFetching;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: progress),
        duration: const Duration(milliseconds: 200),
        builder: (_, double progress, __) {
          return CircularProgressIndicator(
            backgroundColor:
                isDownloading ? primaryColor : Colors.white.withOpacity(0),
            valueColor: AlwaysStoppedAnimation<Color>(
              isFetching ? primaryColor : secondaryColor,
            ),
            strokeWidth: 2.0,
            value: isFetching ? null : progress,
          );
        },
      ),
    );
  }
}

extension on DownloadStatus {
  bool get isFetching => this == DownloadStatus.fetching;
  bool get isDownloading => this == DownloadStatus.downloading;
  bool get isDone => this == DownloadStatus.done;

  bool get isInProgress => isFetching || isDownloading;
}
