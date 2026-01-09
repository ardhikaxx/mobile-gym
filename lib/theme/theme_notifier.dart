import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// WARNA UTAMA
const Color ungu = Color(0xFF8A00C4);

/// THEME CONTROLLER
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

/// PALETTE WARNA LIGHT MODE
class LightPalette {
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color accent = ungu;
  static const Color success = Color(0xFF28A745);
  static const Color info = Color(0xFF17A2B8);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color border = Color(0xFFDEE2E6);
  static const Color shadow = Color(0x1A000000);
}

/// PALETTE WARNA DARK MODE
class DarkPalette {
  static const Color background = Color(0xFF08030C);
  static const Color cardBackground = Color(0xFF2C123A);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFC7B8D6);
  static const Color accent = ungu;
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color border = Color(0xFF3A2845);
  static const Color shadow = Color(0x1AFFFFFF);
}

/// PALETTE WARNA UNGU (untuk gradien dan aksen)
class PurplePalette {
  static const Color lavender = Color(0xFFE39FF6);
  static const Color lilac = Color(0xFFBD93D3);
  static const Color amethyst = Color(0xFF9966CC);
  static const Color wildberry = Color(0xFF8B2991);
  static const Color iris = Color(0xFF9866C5);
  static const Color orchid = Color(0xFFAF69EE);
  static const Color periwinkle = Color(0xFFBD93D3);
  static const Color eggplant = Color(0xFF380385);
  static const Color violet = Color(0xFF710193);
  static const Color purple = Color(0xFFA32CC4);
  static const Color mauve = Color(0xFF7A4A88);
  static const Color heather = Color(0xFF9B7CB8);
}

/// SERVICE UNTUK MENYIMPAN PREFERENSI THEME
class ThemeService {
  static const String _themeKey = 'app_theme';

  /// Mendapatkan theme dari shared preferences
  static Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey) ?? 'light';
    
    switch (themeString) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light; // Default light mode
    }
  }

  /// Menyimpan theme ke shared preferences
  static Future<void> setTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    
    switch (theme) {
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.light:
        themeString = 'light';
        break;
      default:
        themeString = 'light';
    }
    
    await prefs.setString(_themeKey, themeString);
    themeNotifier.value = theme;
  }

  /// Mengubah theme (toggle)
  static Future<void> toggleTheme() async {
    final currentTheme = themeNotifier.value;
    final newTheme = currentTheme == ThemeMode.dark 
        ? ThemeMode.light 
        : ThemeMode.dark;
    
    await setTheme(newTheme);
  }
}

/// EXTENSION UNTUK MEMUDAHKAN AKSES THEME
extension ThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  Color get backgroundColor => isDarkMode 
      ? DarkPalette.background 
      : LightPalette.background;
  
  Color get cardBackground => isDarkMode 
      ? DarkPalette.cardBackground 
      : LightPalette.cardBackground;
  
  Color get textPrimary => isDarkMode 
      ? DarkPalette.textPrimary 
      : LightPalette.textPrimary;
  
  Color get textSecondary => isDarkMode 
      ? DarkPalette.textSecondary 
      : LightPalette.textSecondary;
  
  Color get borderColor => isDarkMode 
      ? DarkPalette.border 
      : LightPalette.border;
}