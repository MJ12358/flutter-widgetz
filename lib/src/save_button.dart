part of flutter_widgetz;

/// {@template flutter_widgetz.SaveButton}
/// Wraps an [ElevatedButton] in an [AnimatedSwitcher].
///
/// This animates between the [ElevatedButton] and
/// the [progressIndicator] when [isSaving] changes.
///
///![SaveButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/save_button1.png)
///
///![SaveButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/save_button2.png)
/// {@endtemplate}
class SaveButton extends StatelessWidget {
  /// {@macro flutter_widgetz.SaveButton}
  const SaveButton({
    super.key,
    this.child = const Text('Save'),
    this.duration = const Duration(milliseconds: 500),
    this.isDisabled = false,
    this.isSaving = false,
    this.onPressed,
    this.progressIndicator = const CircularProgressIndicator(),
  });

  /// The button's label.
  final Widget child;

  /// The duration of the transition.
  final Duration duration;

  /// Determines whether the button is disabled.
  final bool isDisabled;

  /// Determines when to show the [progressIndicator].
  final bool isSaving;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The widget shown when [isSaving] is true.
  final Widget progressIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // this is to avoid a height change during the transition
      height: _kDefaultButtonHeight,
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: duration,
        child: isSaving
            ? progressIndicator
            : CustomElevatedButton(
                color: isDisabled ? Theme.of(context).disabledColor : null,
                onPressed: isDisabled ? null : onPressed,
                child: child,
              ),
      ),
    );
  }
}
