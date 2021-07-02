// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:demo2020/Views/card_settings/flutter_material_pickers/helpers/show_selection_picker.dart';
import 'package:demo2020/Views/card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a list picker that allows an arbitrary list of options to be provided.
class CardSettingsSelectionPicker extends FormField<String>
    implements ICommonFieldProperties {
  CardSettingsSelectionPicker({
    Key key,
    String initialValue,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    // bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.label = 'Label',
    this.visible = true,
    this.onChanged,
    this.requiredIndicator,
    this.labelAlign,
    this.labelWidth,
    this.icon,
    this.contentAlign,
    this.hintText,
    @required this.options,
    this.icons,
    this.values,
    this.showMaterialonIOS,
    this.fieldPadding,
  })  : assert(values == null || options.length == values.length,
            "If you provide 'values', they need the same number as 'options'"),
        assert(icons == null || options.length == icons.length,
            "If you provide 'icons', they need the same number as 'options'"),
        super(
            key: key,
            initialValue: initialValue ?? null,
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<String> field) =>
                (field as _CardSettingsListPickerState)._build(field.context));

  /// fires when the section is changed
  @override
  final ValueChanged<String> onChanged;

  /// The text to identify the field to the user
  @override
  final String label;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign labelAlign;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign contentAlign;

  /// displayes hint text on the selection form.
  final String hintText;

  /// The icon to display to the left of the field content
  @override
  final Icon icon;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double labelWidth;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// A widget to show next to the label if the field is required
  @override
  final Widget requiredIndicator;

  /// a list of options to provide on the selection picker
  final List<String> options;

  /// a list of values that match up with each option. If null, options are values.
  final List<String> values;

  /// optional icons to display next to each picker option
  final List<Icon> icons;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry fieldPadding;

  @override
  _CardSettingsListPickerState createState() => _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsSelectionPicker get widget =>
      super.widget as CardSettingsSelectionPicker;

  List<String> values;
  List<String> options;

  void _showDialog(String label) {
    int optionIndex = values.indexOf(value);
    String option;
    if (optionIndex >= 0) {
      option = options[optionIndex];
    } else {
      optionIndex = 0; // set to first element in the list
    }
    if (showCupertino(context, widget.showMaterialonIOS))
      _showCupertinoBottomPicker(optionIndex);
    else
      _showMaterialSelectionPicker(label, option);
  }

  void _showCupertinoBottomPicker(int optionIndex) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: optionIndex);
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) {
        return _buildCupertinoBottomPicker(
          CupertinoPicker(
            scrollController: scrollController,
            itemExtent: kCupertinoPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              didChange(values[index]);
              widget.onChanged(values[index]);
            },
            children: List<Widget>.generate(options.length, (int index) {
              return Center(
                child: Text(options[index].toString()),
              );
            }),
          ),
        );
      },
    ).then((option) {
      if (option != null) {
        String value = values[options.indexOf(option) ?? 0];
        didChange(value);
        if (widget.onChanged != null) widget.onChanged(value);
      }
    });
  }

  void _showMaterialSelectionPicker(String label, String option) {
    showMaterialSelectionPicker(
      context: context,
      title: label,
      items: options,
      icons: widget.icons,
      selectedItem: option,
      onChanged: (option) {
        if (option != null) {
          int optionIndex = options.indexOf(option);
          String value = values[optionIndex];
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      },
    );
  }

  Widget _buildCupertinoBottomPicker(Widget picker) {
    return Container(
      height: kCupertinoPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    // make local mutable copies of values and options
    options = widget.options;
    if (widget.values == null) {
      // if values are not provided, copy the options over and use those
      values = widget.options;
    } else {
      values = widget.values;
    }

    // get the content label from options based on value
    int optionIndex = values.indexOf(value);
    String content = widget?.hintText ?? '';
    if (optionIndex >= 0) {
      content = options[optionIndex];
    }

    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsListPicker(content);
    else
      return _materialSettingsListPicker(content);
  }

  Widget _cupertinoSettingsListPicker(String content) {
    final ls = labelStyle(context, widget?.enabled ?? true);
    return Container(
      child: widget?.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                _showDialog(widget?.label);
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget?.labelWidth ??
                      CardSettings.of(context).labelWidth ??
                      120.0,
                  child: widget?.requiredIndicator != null
                      ? Text(
                          (widget?.label ?? "") + ' *',
                          style: ls,
                        )
                      : Text(
                          widget?.label,
                          style: ls,
                        ),
                ),
                contentWidget: Text(
                  content,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: (value == null)
                          ? Theme.of(context).hintColor
                          : Theme.of(context).textTheme.subtitle1.color),
                  textAlign: widget?.contentAlign ??
                      CardSettings.of(context).contentAlign,
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsListPicker(String content) {
    var style = Theme.of(context).textTheme.subtitle1.copyWith(
        color: (value == null)
            ? Theme.of(context).hintColor
            : Theme.of(context).textTheme.subtitle1.color);
    if (!widget.enabled) style = style.copyWith(color: Colors.grey);

    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog(widget?.label);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        labelWidth: widget?.labelWidth,
        enabled: widget?.enabled,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
        content: Text(
          content,
          style: style,
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
