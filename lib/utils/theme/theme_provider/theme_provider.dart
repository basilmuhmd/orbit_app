import 'package:flutter/material.dart';
import 'package:orbit_teams_flutter/utils/theme/theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._isDarkMode)
      : _currentTheme =
            _isDarkMode ? TAppTheme.darkTheme : TAppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = TAppTheme.lightTheme;
      _isDarkMode = false;
    } else {
      _currentTheme = TAppTheme.darkTheme;
      _isDarkMode = true;
    }
    notifyListeners();
  }
}
