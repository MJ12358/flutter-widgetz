# Flutter Widgetz

## 8.0.1

- Reuse `trailingText` on `CustomListTile`.

## 8.0.0

- Add `childPadding` to `Accordion`.
- Add `spacing` to `SettingsTile.colorPicker`.

- **BREAKING**:
  - `Accordian`
    - Use Widget instead of String for `title`.
    - Remove unnecessary style due to the above.
  - `Alert`
    - Use Widgets instead of IconData.
  - `AppBar`
    - Opt for Widget only `title` and `subtitle`.
  - `AuthButton`
    - Use Widget instead of String for `text`, now called `child`.
    - Remove unnecessary style due to the above.
  - `AutoComplete`
    - Use widget instead of IconData.
  - `AvatarGroup`/`Avatar`
    - Use Widget instead of IconData.
  - `CheckboxGroup`
    - Use Widget instead of IconData.
  - `ColorPicker`/`ColorField`
    - Use Widget instead of IconData.
    - Use Widget for `title` instead of String.
  - `Countdown`
    - Remove text and use widgets for labels.
  - `CounterField`
    - Use Widgets instead of IconData
  - `DateField`/`DateRangeField`
    - User Widgets instead of IconData.
  - `DropdownField`
    - Use Widgets instead of IconData.
  - `DuelingPicklist`
    - Use Widgets instead of Strings for labels.
  - `DurationField`
    - Use Widget instead of IconData.
  - `CustomElevatedButton`
    - Use Widget instead of String for `text`, now called `child`.
  - `CustomFloatingActionButton`
    - Use Widget instead of IconData for `icon`, now called `child`.
  - `CustomInputDecorator`
    - Remove text in favor of child.
    - Use Widget instead of IconData.
  - `Link`
    - Use Widget instead of String.
    - Remove unnecessary style due to the above.
  - `CustomListTile`
    - Remove text and use widgets for title/subtitle etc.
  - `CustomPopupMenuItem`
    - Use Widget instead of String for `text`, now called `child`.
  - `RadioGroup`
    - Use Widget instead of IconData.
  - `SaveButton`
    - Use Widget instead of String for `text`, now called `child`.
  - `CustomSearchBar`
    - Use Widget instead of IconData.
  - `CustomSimpleDialogOption`
    - Use Widget instead of String for `text`, now called `child`.
  - `CustomSlider`
    - Use Widgets instead of IconData.
  - `SpacedColumn`
    - Opt for spacer widget instead of spacing.
  - `SpacedRow`
    - Opt for spacer widget instead of spacing.
    - Use Widget instead of String for `title`.
    - Remove unnecessary style due to the above.
  - `CustomTextField`
    - Opt for help widget instead of helpText.
    - Use Widget instead of IconData.
  - `TimeField`
    - Use Widget instead of IconData.
  - `Welcome`
    - Use Widgets instead of Strings.

## 7.8.1

- Fix default title on `ColorPicker.compact`.

## 7.8.0

- Add `compact` named constructor to `ColorPicker`.

## 7.7.2

- Add params to `CustomScaffold`.

## 7.7.1

- Fix `CustomBottomAppBar` coloring.

## 7.7.0

- Add `CustomListView`.

## 7.6.0

- Add `GroupedListView`.
- Fix `RatingBar` background color.

## 7.5.1

- Fix a comment template.
- Allow `semanticLabel` on `CustomDrawer`.

## 7.5.0

- Add `licenses` named constructor to `SettingsTile`.

## 7.4.2

- Add missing onChanged handler to a settingsTile.

## 7.4.1

- Make `WelcomeBackground` a public widget.

## 7.4.0

- Add `immersiveMode` and `timeDilation` named constructors to `SettingsTile`.

## 7.3.1

- Fix color of `WelcomeContent` asset.

## 7.3.0

- Add `darkMode` named constructor to `SettingsTile`.

## 7.2.1

- Fix `WelcomeContent` asset color.

## 7.2.0

- Introduce `Welcome` widget.

## 7.1.1

- Fix default behavior of physics in `SettingsList`.

## 7.1.0

- Add `colorPicker` named constructor to `SettingsTile`.

## 7.0.1

- Fix screenshot links.

## 7.0.0

- **BREAKING**:
  - `CustomDrawer`
    - Require `delegate` but add `count` and `builder` named constructors.
  - `Countdown`
    - Rename a named constructor for consistancy.
  - `FeedbackBar`
    - Use widgets instead of strings for items.

- Other:
  - Introduce `Settings` set of widgets.
  - Add `color` param to `CustomDrawer`.
  - Add `package` param to `CustomImage`.
  - Upload some screenshots.

## 6.5.2

- Fix `InputDecorator` assert to allow empty string.

## 6.5.1

- Modify `CustomImage.dynamic` string parsing.

## 6.5.0

- Add `DirectionalPad` widget.
- Add `orientation` param to `FeedbackBar`.
- Add `backgroundColor` to `Shimmer`.

## 6.4.0

- Add `FeedbackBar` widget.

## 6.3.0

- Add `RatingSummary` widget.

## 6.2.1

- Fix `errorWidget` not showing in `CustomImage`.

## 6.2.0

- Add `dynamic` constructor to `CustomImage`.

## 6.1.0

- Add `CustomInputDecorator` widget.
- Add `PercentIndicator` widget.
- Add `Poll` widget.
- Add `crossAxisAlignment`, `height` and `notchMargin` params to `CustomBottomAppBar`.
- Add `backgroundColor` to `CustomProgressIndicator`.
- Allow 0 - 100 values for `CustomProgressIndicator` and `PercentIndicator`.
- Fix possible issue with TextInputAction.newline in `CustomTextField`.
- Fix `Countdown` date overflow.

## 6.0.0

- **BREAKING**:
  - `ColorField`
    - Require `modalBuilder` but add `bottomSheet` and `dialog` named constructors.
    - Change behavior of `defaultStringForColor`.
  - `ColorPicker`
    - Require `decoration` but add `circle` and `rectangle` named constructors.
  - `Countdown`
    - Require `decoration` but add `circle` and `rectangle` named constructors.
  - `Link`
    - Remove `text` named constructor in favor of an implicit one.

- Other:
  - Add min/max width params to `AuthButton`.
  - Use `CustomImage` within `CustomAvatar`.
  - Fix `Countdown` default text/separator colors.
  - Add `enableFeedback` param to `CustomBottomNavigationBar`.
  - Add `autofocus` and `clipBehavior` to `CustomFloatingActionButton`.
  - Add `flashlight` constructor to `CustomPlaceholder`.
  - Add more params to `CustomProgressIndicator`.
  - Edit/add comments.

## 5.4.0

- Add `CustomBottomAppBar` widget.
- Add `alignment`, `opacity` and `scale` params to `CustomImage`.

## 5.3.2

- Add `primaryColor` and `trailingText` params to `CustomListTile`.

## 5.3.1

- Allow nullable image params.

## 5.3.0

- Add `CustomImage` widget.
- Add `memory` constructor to `CustomAvatar`.

## 5.2.1

- Add `dense` param to `CustomListTile`.

## 5.2.0

- Add `CustomAppBar` widget.
- Add `CustomListTile` widget.
- Add `CustomTabBar` widget.
- Update example app.

## 5.1.2

- Fix `Autocomplete` height when compared to other fields.

## 5.1.1

- Fix `Button` minWidth and textColor.
- Fix `SaveButton` transition height.

## 5.1.0

- Add `AuthButton` widget.
- Add `Shimmer` widget.

## 5.0.3

- Use `ThemeData.estimateBrightnessForColor` method instead when getting `ColorExtension.brightness`.

## 5.0.2

- Add index params to `CustomBottomNavigationBar` and `CustomNavigationRail`.

## 5.0.1

- **BREAKING**:
  - Increase Dart sdk minimum version.

## 4.9.4

- Update `CustomTextField.onEditingComplete` to default next/previous/unfocus nodes.
- Prevent `CustomOrientationBuilder.onChanged` from running on initialization.

## 4.9.3

- Add `onChanged` param to `CustomOrientationBuilder`.

## 4.9.2

- Make `CustomNavigationRail` scrollable.
- Update lints.

## 4.9.1

- Add `onEditingComplete` param to `CustomTextField`.
- Put Spaced Column/Row defaultFilter into own function.

## 4.9.0

- Add filtered constructor to `SpacedColumn` and `SpacedRow`.

## 4.8.0

- Add spacer param to `SpacedColumn` and `SpacedRow`.

## 4.7.0

- Add `CustomProgressIndicator`.

## 4.6.0

- Add `CustomLayoutBuilder`.
- Add `CustomNavigationRail`.

## 4.5.0

- Add `Countdown` widget.
- Optimize ThemeData calls.

## 4.4.0

- Add FocusNodes to Inputs.

## 4.3.0

- Add `DurationField`.
- Add `DurationPicker`.

## 4.2.0

- Add icon param to `DropdownField`.
- Fix DropdownField density.
- Add `mainAxisExtent` param to `CustomSliverGrid.count`.
- Add `CustomSliverGrid.extent` factory.
- Add general constructors for `CustomSliverGrid` and `CustomSliverList`.
- Add `mainAxisSize` param to `SpacedRow`.

## 4.1.0

- Add `CustomOrientationBuilder`.

## 4.0.0

- **BREAKING**:
  - Change 'Input' naming to 'Field' to avoid conflicts and to better conform to standards.

## 3.3.0

- Add `ColorField`.
- Allow null for `ColorPicker.shape` and `ColorPicker.title`;

## 3.2.0

- Add `AvatarGroup`.
- Add `CustomBadge`.
- Add `CustomButton`.
- Add `DateRangeField`.
- Add `DuelingPicklist`.
- Add `TimeField`.
- Add `shape` param to `ColorPicker`.
- Fix errorBuilder in Avatar factories.

## 3.1.0

- Update dependency constraints.

## 3.0.0

- **BREAKING**:
  - Update to Material 3.

## 2.0.0

- **BREAKING**:
  - Refactor widgets to conform to standards.

## 1.3.12

- Add `Carousel`.

## 1.3.11

- Add `ReorderableListView.separated`.
- Add `Link`.

## 1.3.10

- Increase tap target of `CheckboxField`.
- Add more params to `ColorPicker` and adjust contrast.

## 1.3.9

- Add more params to `CustomSearchBar`.
- Use Flutter duration constant.

## 1.3.8

- Increase tap target of `DropdownField`.
- Add a param to `CustomScaffold`.

## 1.3.7

- Add more params to `SpacedColumn`.

## 1.3.6

- Add `checked` and `icon` factories to `CustomPopupMenuItem`.
- Add `checked`, `icon` and `tile` factories to `CustomSimpleDialogOption`.

## 1.3.5

- Refactor `CustomSimpleDialogOption` and `CustomPopupMenuItem`.

## 1.3.4

- Add `CustomPopupMenuItem`.
- Add `icon` param to `CustomAvatar`.
- Add `padding` param to `CustomPlaceholder`.

## 1.3.3

- Add `count` factory to `CustomSliverGrid`.

## 1.3.2

- Add hintText to `CustomTextField`.
- Add scrollPadding to `CustomAutocomplete`.
- Add titleStyle to `Accordion`.
- Add titleStyle to `SpacedRow`.
- Add more docs.

## 1.3.1

- Add `padding` to `CustomSliverList` and `CustomSliverGrid`.
- Add more docs and comments.

## 1.3.0

- Add `CustomSliverList` widget.

## 1.2.2

- Revise theming.

## 1.2.1

- Fix elevated button text color.

## 1.2.0

- Add save button.

## 1.1.0

- Add drawer and floating action button.

## 1.0.1

- Hotfix scaffold context.

## 1.0.0

- Initial release!

## 0.0.6

- Add rating bar.

## 0.0.5

- Add more comments.
- Add padding options to search bar.
- Add more params to scaffold.

## 0.0.4

- Add more comments.
- Allow more user defined params.

## 0.0.3

- Hotfix checkbox onChanged.

## 0.0.2

- Add `CustomScaffold` widget.
- Allow more user params with `CustomSearchBar`.
- Set default icon on `DateField`.

## 0.0.1

- Initial developer preview.
