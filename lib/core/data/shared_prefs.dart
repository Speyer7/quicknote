import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String isDarkModeKey = "dark_mode";
  static const String fontSizeKey = "font_size";
  static const String colorTheme = "color_theme";

  static Future<void> setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isDarkModeKey, isDarkMode);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isDarkModeKey) ?? false;
  }

  static Future<void> setFontSize(int fontSizeLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(fontSizeKey, fontSizeLevel);
  }

  static Future<int> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(fontSizeKey) ?? 2;
  }

  static Future<void> setColorTheme(int colorThemeLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(colorTheme, colorThemeLevel);
  }

  static Future<int> getColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(colorTheme) ?? 2;
  }
}