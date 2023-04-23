import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {
  BuildContext? context;
  ThemeData? _themeData;

  ThemeProvider(BuildContext context) {
    _themeData = StylesSettings.lightTheme(context);
  }

  getThemeData() => _themeData;
  setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
