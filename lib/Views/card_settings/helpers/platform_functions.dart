import 'dart:io';
import 'package:demo2020/Views/card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// this centralizes code to determine if we want to display the cupertino
/// version or the material version, since this can be determined by
/// several settings throughout the package
bool showCupertino(
  BuildContext context,
  bool showMaterialonIOS, {
  bool mockIOS = false,
}) {
  // don't show on web
  if (kIsWeb) return false;

  // if we are on iOS then determine if we want material
  if (mockIOS || Platform.isIOS) {
    // if showMaterialonIOS not specified calculate it
    if (showMaterialonIOS == null) {
      // default to cupertino
      showMaterialonIOS = false;

      if (context != null)
        // set showMaterialOnIOS to parent CardSettings value
        showMaterialonIOS = CardSettings.of(context).showMaterialonIOS;
    }

    return !showMaterialonIOS;
  }

  // material by default
  return false;
}

/// This centralizes the style calculations for field labels, used by almost all widgets in this package
TextStyle labelStyle(BuildContext context, bool enabled) {
  var theme = Theme.of(context);
  var style = theme.textTheme.subtitle1;
  if (!enabled)
    style = style.copyWith(color: theme.disabledColor ?? Colors.grey);
  return style;
}

/// This centralizes the style calculations for content, used by almost all widgets in this package
TextStyle contentStyle(BuildContext context, dynamic value, bool enabled) {
  var theme = Theme.of(context);
  var style = theme.textTheme.subtitle1.copyWith(
      color:
          (value == null) ? theme.hintColor : theme.textTheme.subtitle1.color);
  if (!enabled)
    style = style.copyWith(color: theme.disabledColor ?? Colors.grey);
  return style;
}
