part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAutocomplete}
/// Wraps `RawAutocomplete` with `LayoutBuilder`
/// in order to prevent the width from overflowing the screen.
///
/// This should solve https://github.com/flutter/flutter/issues/78746
/// {@endtemplate}
class CustomAutocomplete<T extends Object> extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomAutocomplete}
  const CustomAutocomplete({
    Key? key,
    required this.onChanged,
    required this.onSelected,
    required this.optionsBuilder,
    required this.displayStringForOption,
    this.autofocus = false,
    this.errorText,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.prefixIcon,
    this.showError = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  }) : super(key: key);

  final bool autofocus;
  final String? errorText;
  final String initialValue;
  final TextInputType? keyboardType;
  final String? labelText;
  final IconData? prefixIcon;
  final bool showError;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<T> onSelected;
  final List<T> Function(String) optionsBuilder;
  final AutocompleteOptionToString<T> displayStringForOption;

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
            return CustomTextFormField(
              autofocus: autofocus,
              controller: textEditingController,
              errorText: errorText,
              focusNode: focusNode,
              keyboardType: keyboardType,
              labelText: labelText,
              prefixIcon: prefixIcon,
              // a hack to force the input enough room for the dropdown
              scrollPadding: const EdgeInsets.only(bottom: 200.0),
              showError: showError,
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
    required this.onSelected,
    required this.options,
    required this.constraints,
    required this.displayStringForOption,
  }) : super(key: key);

  final ValueChanged<T> onSelected;
  final Iterable<T> options;
  final BoxConstraints constraints;
  final AutocompleteOptionToString<T> displayStringForOption;

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
