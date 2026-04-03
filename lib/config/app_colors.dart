// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
//  static const primary = Color(0xFFA6914C); // Color(0xFFCEA955);
  // static const primary = const Color(0xFF252258);
  static const black = Color(0xFF262626);
  static const grey = Colors.grey;
  static const Color white = Colors.white;
  static const secondary  = Color(0xFFebeff3);
  static const countColor  = Color(0xFFe8dbfd);
  static const drawerSelectedColor = Color(0xFF4b68ff);

  static MaterialColor primary =
      generateMaterialColor(color: const Color(0xFF0D1321));

  // static MaterialColor secondary =
  //     generateMaterialColor(color: const Color(0xFFC5832B));

  static MaterialColor generateMaterialColor({required Color color}) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
