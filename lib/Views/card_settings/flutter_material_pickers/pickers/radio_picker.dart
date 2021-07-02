// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


/// This helper widget manages a scrollable checkbox list inside a picker widget.
class RadioPicker extends StatefulWidget {
  RadioPicker({
    Key key,
    this.items,
    this.initialItem,
    this.onChanged,
  }) : super(key: key);

  // Constants
  static const double defaultItemHeight = 40.0;

  // Events
  final ValueChanged<String> onChanged;

  // Variables
  final List<String> items;
  final String initialItem;

  @override
  RadioPickerState createState() {

    return RadioPickerState(initialItem);
  }
}

class RadioPickerState extends State<RadioPicker> {
  RadioPickerState(this.selectedValue);

  String selectedValue;

  @override
  Widget build(BuildContext context) {
    int itemCount = widget.items.length;
    var theme = Theme.of(context);

    return Container(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            bool isSelectedItem = (widget.items[index] == selectedValue);

            return RadioListTile<String>(
              groupValue: selectedValue,
              activeColor: theme.accentColor,
              title: Text(
                widget.items[index],
                style: (isSelectedItem)
                    ? TextStyle(color: theme.accentColor)
                    : TextStyle(color: theme.textTheme.bodyText2?.color),
              ),
              value: widget.items[index],
              onChanged: (String value) {
                setState(() {
                  selectedValue = value;
                  widget.onChanged(selectedValue);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
