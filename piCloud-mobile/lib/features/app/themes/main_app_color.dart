import 'package:flutter/material.dart';

class MainAppColor extends MaterialColor {
  MainAppColor() : super(_primaryColorHex, _swatch);

  static const int _primaryColorHex = 0xffED64A6;

  static Map<int, Color> get _swatch => {
        50: const Color(0xFFFFF5F7),
        100: const Color(0xFFFED7E2),
        200: const Color(0xFFFBB6CE),
        300: const Color(0xFFF687B3),
        400: const Color(_primaryColorHex),
        500: const Color(0xFFD53F8C),
        600: const Color(0xFFB83280),
        700: const Color(0xFF97266D),
        800: const Color(0xFF702459),
        900: const Color(0xFF521B41),
      };
}
