part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAutocomplete}
/// Wraps [RawAutocomplete] with [LayoutBuilder]
/// in order to prevent the width from overflowing the screen.
///
/// This should solve https://github.com/flutter/flutter/issues/78746
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
    this.labelText,
    this.prefixIcon,
    this.scrollPadding = const EdgeInsets.all(200.0),
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
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final IconData? prefixIcon;

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
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              onChanged: onChanged,
              suffixIcon: _getSuffixIcon(textEditingController),
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

  Widget? _getSuffixIcon(TextEditingController controller) {
    if (controller.value == TextEditingValue.empty) {
      return null;
    }
    return ExcludeFocus(
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          controller.value = TextEditingValue.empty;
          onChanged(controller.text);
        },
      ),
    );
  }
}

class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    Key? key,
    required this.constraints,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
  }) : super(key: key);

  final BoxConstraints constraints;
  final AutocompleteOptionToString<T> displayStringForOption;
  final ValueChanged<T> onSelected;
  final Iterable<T> options;

  @override
  Widget build(BuildContext context) {
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
                      SchedulerBinding.instance
                          .addPostFrameCallback((Duration timeStamp) {
                        Scrollable.ensureVisible(context, alignment: 0.5);
                      });
                    }

                    return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
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
