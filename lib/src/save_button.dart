part of flutter_widgetz;

/// {@template flutter_widgetz.SaveButton}
/// Wraps an [ElevatedButton] in an [AnimatedSwitcher].
///
/// This animates between the [ElevatedButton] and
/// the [progressIndicator] when [isSaving] changes.
/// {@endtemplate}
class SaveButton extends StatelessWidget {
  /// {@macro flutter_widgetz.SaveButton}
  const SaveButton({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.isSaving = false,
    this.onPressed,
    this.progressIndicator = const CircularProgressIndicator(),
    this.text = 'Save',
  });

  /// The duration of the transition.
  final Duration duration;

  /// Determines when to show the [progressIndicator].
  final bool isSaving;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The widget shown when [isSaving] is true.
  final Widget progressIndicator;

  /// The button's label.
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: isSaving
          ? progressIndicator
          : CustomElevatedButton(
              onPressed: onPressed,
              text: text,
            ),
    );
  }
}
