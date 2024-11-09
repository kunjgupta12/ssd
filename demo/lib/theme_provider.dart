import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class themechanger with ChangeNotifier {
  var _themeMode = ThemeMode.dark;
  ThemeMode get thememode => _themeMode;
  void setTheme(themeMode) {
    _themeMode = thememode;
    notifyListeners();
  }
}
