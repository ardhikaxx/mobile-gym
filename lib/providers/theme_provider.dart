import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes.dart';

enum ThemeModeType {
  system,
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.system;
  ThemeData _currentTheme = ThemeClass.lightTheme;
  
  ThemeProvider() {
    _loadThemePreference();
  }
  
  ThemeModeType get themeMode => _themeMode;
  ThemeData get currentTheme => _currentTheme;
  
  // Get actual ThemeMode untuk MaterialApp
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case ThemeModeType.light:
        return ThemeMode.light;
      case ThemeModeType.dark:
        return ThemeMode.dark;
      case ThemeModeType.system:
        return ThemeMode.system;
    }
  }
  
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt('theme_mode') ?? 0;
      
      _themeMode = ThemeModeType.values[themeIndex];
      _updateCurrentTheme();
      notifyListeners();
    } catch (e) {
      print('Error loading theme preference: $e');
    }
  }
  
  Future<void> setThemeMode(ThemeModeType themeMode) async {
    _themeMode = themeMode;
    _updateCurrentTheme();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', themeMode.index);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
    
    notifyListeners();
  }
  
  void _updateCurrentTheme() {
    if (_themeMode == ThemeModeType.light) {
      _currentTheme = ThemeClass.lightTheme;
    } else if (_themeMode == ThemeModeType.dark) {
      _currentTheme = ThemeClass.darkTheme;
    } else {
      // System mode - check device brightness
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      _currentTheme = brightness == Brightness.dark 
          ? ThemeClass.darkTheme 
          : ThemeClass.lightTheme;
    }
  }
  
  // Helper method untuk mendapatkan nama tema
  String getThemeName() {
    switch (_themeMode) {
      case ThemeModeType.system:
        return 'Sesuai Sistem';
      case ThemeModeType.light:
        return 'Mode Terang';
      case ThemeModeType.dark:
        return 'Mode Gelap';
    }
  }
  
  // Helper method untuk mendapatkan icon
  IconData getThemeIcon() {
    switch (_themeMode) {
      case ThemeModeType.system:
        return Icons.auto_awesome;
      case ThemeModeType.light:
        return Icons.light_mode;
      case ThemeModeType.dark:
        return Icons.dark_mode;
    }
  }
  
  // Helper method untuk mendapatkan color
  Color getThemeColor() {
    switch (_themeMode) {
      case ThemeModeType.system:
        return Colors.blue;
      case ThemeModeType.light:
        return Colors.amber;
      case ThemeModeType.dark:
        return Colors.indigo;
    }
  }
}