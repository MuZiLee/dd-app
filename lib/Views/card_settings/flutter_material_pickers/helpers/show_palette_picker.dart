// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:demo2020/Views/card_settings/flutter_colorpicker/material_picker.dart';
import 'package:demo2020/Views/card_settings/flutter_material_pickers/dialogs/responsive_dialog.dart';
import 'package:flutter/material.dart';

/// Allows Material palette selection of a color
void showMaterialPalettePicker({
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
            child: MaterialPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) => selectedColor = color,
              enableLabel: true, // only on portrait mode
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
