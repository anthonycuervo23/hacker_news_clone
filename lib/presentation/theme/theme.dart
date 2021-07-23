import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF202022),
    accentColor: const Color(0xFFFF965b),
    secondaryHeaderColor: const Color(0xFFFF6600),
    scaffoldBackgroundColor: const Color(0xFF202022),
    cardTheme: const CardTheme(
      color: Color(0xFF29292B),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF272729),
    ),
    bottomAppBarColor: const Color(0xFF151517),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF202022)));
