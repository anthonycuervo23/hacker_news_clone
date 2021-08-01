import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//DARK
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

//LIGHT
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    accentColor: Colors.orange[800],
    secondaryHeaderColor: const Color(0xFFFF6600), //0xFF01A173
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), //0xFFF5F5FE
    cardTheme: const CardTheme(
      color: Color(0xFFF1F1F1),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF9F9F9),
    ),
    bottomAppBarColor: const Color(0xFFE6E6E6),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF5F5F5)));

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }
  final String key = 'theme';
  SharedPreferences? prefs;
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    prefs!.setBool(key, _darkTheme);
  }
}
