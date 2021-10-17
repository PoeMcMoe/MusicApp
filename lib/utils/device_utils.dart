import 'package:flutter/material.dart';

class DeviceUtils {
  DeviceUtils._();

  static void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  static double getScaledSize(BuildContext context, {double scale = 1}) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  static double getScaledWidth(BuildContext context, {double scale = 1}) =>
      scale * MediaQuery.of(context).size.width;

  static double getScaledHeight(BuildContext context, {double scale = 1}) =>
      scale * MediaQuery.of(context).size.height;

  static EdgeInsets getDevicePadding(BuildContext context) =>
      MediaQuery.of(context).padding;
}
