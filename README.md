# Flutter Widgetz

## Features

- CustomAutocomplete
- CustomAvatar
- CustomBody
- CustomBottomNavigationBar
- CustomColorPicker
- CustomDivider
- CustomElevatedButton
- CustomInputCheckbox
- CustomInputDate
- CustomInputDropdown
- CustomPlaceholder
- CustomScaffold
- CustomSearchBar
- CustomSimpleDialogOption
- SpacedColumn
- SpacedRow
- CustomTextFormField

## Getting started

```yaml
flutter_widgetz: ^0.0.2
```

## Usage

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SpacedColumn(
        children: <Widget>[
          const CustomPlaceholder(
            text: 'Hi There',
          ),
          CustomElevatedButton(
            onPressed: () {},
            text: 'A Button',
          ),
        ],
      ),
    );
  }
}
```

## Additional information

The [generated documentation](https://pub.dev/documentation/flutter_widgetz/latest) has a great overview of all that is available.
