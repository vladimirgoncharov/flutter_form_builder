import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSearchableDropdown<T> extends FormBuilderField {
  /// final List<DropdownMenuItem<T>> items;

  ///DropDownSearch hint
  final String hint;

  ///show/hide the search box
  final bool showSearchBox;

  ///true if the filter on items is applied onlie (via API)
  final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool showClearButton;

  ///offline items list
  final List<T> items;

  ///selected item
  final T selectedItem;

  ///function that returns item from API
  final dropdown_search.DropdownSearchOnFind<T> onFind;

  ///to customize list of items UI
  final dropdown_search.DropdownSearchBuilder<T> dropdownBuilder;

  ///to customize selected item
  final dropdown_search.DropdownSearchPopupItemBuilder<T> popupItemBuilder;

  ///decoration for search box
  final InputDecoration searchBoxDecoration;

  ///the title for dialog/menu/bottomSheet
  final Color popupBackgroundColor;

  ///custom widget for the popup title
  final Widget popupTitle;

  ///customize the fields the be shown
  final dropdown_search.DropdownSearchItemAsString<T> itemAsString;

  ///	custom filter function
  final dropdown_search.DropdownSearchFilterFn<T> filterFn;

  ///MENU / DIALOG/ BOTTOM_SHEET
  final dropdown_search.Mode mode;

  ///the max height for dialog/bottomSheet/Menu
  final double maxHeight;

  ///the max width for the dialog
  final double dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItem;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final dropdown_search.DropdownSearchCompareFn<T> compareFn;

  ///custom layout for empty results
  final WidgetBuilder emptyBuilder;

  ///custom layout for loading items
  final WidgetBuilder loadingBuilder;

  ///custom layout for error
  final dropdown_search.ErrorBuilder errorBuilder;

  ///the search box will be focused if true
  final bool autoFocusSearchBox;

  ///custom shape for the popup
  final ShapeBorder popupShape;

  ///handle auto validation
  final bool autoValidate;

  ///custom dropdown clear button icon widget
  final Widget clearButton;

  ///custom dropdown icon button widget
  final Widget dropDownButton;

  ///If true, the dropdownBuilder will continue the uses of material behavior
  ///This will be useful if you want to handle a custom UI only if the item !=null
  final bool dropdownBuilderSupportsNullItem;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final dropdown_search.DropdownSearchPopupItemEnabled<T> popupItemDisabled;

  ///set a custom color for the popup barrier
  final Color popupBarrierColor;

  FormBuilderSearchableDropdown({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.items,
    this.autoValidate = false,
    this.mode = dropdown_search.Mode.DIALOG,
    this.hint,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.showSearchBox = true,
    this.showClearButton = false,
    this.searchBoxDecoration,
    this.popupBackgroundColor,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItem = false,
    this.compareFn,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.autoFocusSearchBox = false,
    this.dialogMaxWidth,
    this.clearButton,
    this.dropDownButton,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderSearchableDropdownState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: dropdown_search.DropdownSearch<T>(
                items: items,
                maxHeight: 300,
                onFind: onFind,
                onChanged: (val) {
                  state.requestFocus();
                  state.didChange(val);
                },
                showSearchBox: showSearchBox,
                hint: hint,
                enabled: enabled,
                autoFocusSearchBox: autoFocusSearchBox,
                autoValidate: autoFocusSearchBox,
                clearButton: clearButton,
                compareFn: compareFn,
                dialogMaxWidth: dialogMaxWidth,
                dropdownBuilder: dropdownBuilder,
                dropdownBuilderSupportsNullItem:
                    dropdownBuilderSupportsNullItem,
                dropDownButton: dropDownButton,
                dropdownSearchDecoration:
                    InputDecoration.collapsed(hintText: hint),
                emptyBuilder: emptyBuilder,
                errorBuilder: errorBuilder,
                filterFn: filterFn,
                isFilteredOnline: isFilteredOnline,
                itemAsString: itemAsString,
                loadingBuilder: loadingBuilder,
                popupBackgroundColor: popupBackgroundColor,
                mode: mode,
                popupBarrierColor: popupBarrierColor,
                popupItemBuilder: popupItemBuilder,
                popupItemDisabled: popupItemDisabled,
                popupShape: popupShape,
                popupTitle: popupTitle,
                searchBoxDecoration: searchBoxDecoration,
                selectedItem: state.value,
                showClearButton: showClearButton,
                showSelectedItem: showSelectedItem,
              ),
            );
          },
        );

  @override
  _FormBuilderSearchableDropdownState createState() =>
      _FormBuilderSearchableDropdownState();
}

class _FormBuilderSearchableDropdownState extends FormBuilderFieldState {
  @override
  FormBuilderSearchableDropdown get widget =>
      super.widget as FormBuilderSearchableDropdown;
}