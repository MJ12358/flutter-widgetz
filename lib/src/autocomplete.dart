part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAutocomplete}
/// Wraps [RawAutocomplete] with [LayoutBuilder]
/// in order to prevent the width from overflowing the screen.
///
/// This should solve https://github.com/flutter/flutter/issues/78746
///
///![CustomAutoComplete](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/autocomplete.png)
/// {@endtemplate}
class CustomAutocomplete<T extends Object> extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomAutocomplete}
  const CustomAutocomplete({
    super.key,
    required this.onChanged,
    required this.onSelected,
    required this.optionsBuilder,
    this.autofocus = false,
    this.displayStringForOption = _defaultStringForOption,
    this.errorText,
    this.hasError = false,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.prefixIcon,
    this.scrollPadding = const EdgeInsets.all(200.0),
    this.restorationId,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  });

  /// Called when the value of the input changes.
  final ValueChanged<String> onChanged;

  /// Called when a selection is made.
  final ValueChanged<T> onSelected;

  /// A function that returns the current selectable
  /// options objects given the current [TextEditingValue.text].
  final List<T> Function(String) optionsBuilder;

  /// Determines whether to auto focus this input.
  final bool autofocus;

  /// Returns the string to display in the field when the option is selected.
  final AutocompleteOptionToString<T> displayStringForOption;

  /// The text shown when there is an error.
  final String? errorText;

  /// Determines if an error should be displayed.
  final bool hasError;

  /// The initial value of this input.
  final String initialValue;

  /// The type of information for which to optimize the text input control.
  final TextInputType? keyboardType;

  /// An optional label for this input.
  /// This defaults to an empty string in order to keep the
  /// height of this widget the same as other text fields.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// Restoration ID to save and restore the state of the form field.
  final String? restorationId;

  /// Used to allow the input enough room for the dropdown.
  final EdgeInsets scrollPadding;

  /// Determines whether to show an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// An action the user has requested the text input control to perform.
  final TextInputAction? textInputAction;

  static String _defaultStringForOption(Object? option) {
    return option?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return RawAutocomplete<T>(
          displayStringForOption: displayStringForOption,
          initialValue: TextEditingValue(text: initialValue),
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return CustomTextField(
              autofocus: autofocus,
              controller: textEditingController,
              errorText: errorText,
              focusNode: focusNode,
              keyboardType: keyboardType,
              labelText: labelText,
              prefixIcon: prefixIcon,
              scrollPadding: scrollPadding,
              hasError: hasError,
              restorationId: restorationId,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              onChanged: onChanged,
              suffixIcon: _SuffixIcon(
                controller: textEditingController,
                onChanged: onChanged,
              ),
              value: initialValue,
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return <T>[];
            }
            return optionsBuilder(textEditingValue.text);
          },
          optionsViewBuilder: (
            BuildContext context,
            ValueChanged<T> onSelected,
            Iterable<T> options,
          ) {
            return _AutocompleteOptions<T>(
              onSelected: onSelected,
              options: options,
              constraints: constraints,
              displayStringForOption: displayStringForOption,
            );
          },
          onSelected: onSelected,
        );
      },
    );
  }
}

class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    super.key,
    required this.constraints,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
  });

  final BoxConstraints constraints;
  final AutocompleteOptionToString<T> displayStringForOption;
  final ValueChanged<T> onSelected;
  final Iterable<T> options;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200.0,
            maxWidth: constraints.maxWidth,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (_, int index) {
              final T option = options.elementAt(index);

              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (BuildContext context) {
                    final bool highlight =
                        AutocompleteHighlightedOption.of(context) == index;

                    if (highlight) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Scrollable.ensureVisible(context, alignment: 0.5);
                      });
                    }

                    return Container(
                      color: highlight ? theme.focusColor : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(displayStringForOption(option)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SuffixIcon extends StatefulWidget {
  const _SuffixIcon({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<_SuffixIcon> createState() => __SuffixIconState();
}

class __SuffixIconState extends State<_SuffixIcon> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _clearText() {
    widget.controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return ExcludeFocus(
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _clearText,
      ),
    );
  }
}
