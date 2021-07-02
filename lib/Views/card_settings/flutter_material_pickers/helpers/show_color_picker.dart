// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:one/Views/card_settings/flutter_colorpicker/colorpicker.dart';
import 'package:one/Views/card_settings/flutter_colorpicker/hsv_picker.dart';
import 'package:one/Views/card_settings/flutter_material_pickers/dialogs/responsive_dialog.dart';
import 'package:flutter/material.dart';

/// Allows RGB selection of a color.
void showMaterialColorPicker({
  BuildContext context,
  String title = "Pick a color",
  Color selectedColor,
  Color headerColor,
  Color headerTextColor,
  Color backgroundColor,
  Color buttonTextColor,
  String confirmText,
  String cancelText,
  double maxLongSide,
  double maxShortSide,
  ValueChanged<Color> onChanged,
  VoidCallback onConfirmed,
  VoidCallback onCancelled,
}) {
  showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return OrientationBuilder(
        builder: (context, orientation) {
          return ResponsiveDialog(
            context: context,
            title: title,
            headerColor: headerColor,
            headerTextColor: headerTextColor,
            backgroundColor: backgroundColor,
            buttonTextColor: buttonTextColor,
            confirmText: confirmText,
            cancelText: cancelText,
            maxLongSide: maxLongSide,
            maxShortSide: maxLongSide,
            forcePortrait: true,
            child: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) => selectedColor = color,
                colorPickerWidth: 1000.0,
                pickerAreaHeightPercent: 0.3,
                enableAlpha: true,
                displayThumbColor: true,
                paletteType: PaletteType.hsv,
              ),
            ),
            okPressed: () => Navigator.of(context).pop(selectedColor),
          );
        },
      );
    },
  ).then((selection) {
    if (onChanged != null && selection != null) onChanged(selection);
    if (onCancelled != null && selection == null) onCancelled();
    if (onConfirmed != null && selection != null) onConfirmed();
  });
}
