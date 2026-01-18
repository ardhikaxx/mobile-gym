import 'package:flutter/material.dart';

class ThemeClass {
  // Light Mode Colors
  static const Color lightPrimaryColor = Color(0xFFAF69EE);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF212529);
  static const Color textSecondaryLight = Color(0xFF6C757D);
  static const Color textHintLight = Color(0xFFADB5BD);
  static const Color dividerLight = Color(0xFFE9ECEF);
  static const Color errorLight = Color(0xFFDC3545);
  static const Color successLight = Color(0xFF28A745);
  static const Color warningLight = Color(0xFFFFC107);
  static const Color infoLight = Color(0xFF17A2B8);

  // Dark Mode Colors
  static const Color darkPrimaryColor = Color(0xFFAF69EE);
  static const Color backgroundDark = Color(0xFF08030C);
  static const Color cardBackgroundDark = Color(0xFF2C123A);
  static const Color surfaceDark = Color(0xFF1E1E2C);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFC7B8D6);
  static const Color textHintDark = Color(0xFF6D6875);
  static const Color dividerDark = Color(0xFF3D3D4E);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color successDark = Color(0xFF81C784);
  static const Color warningDark = Color(0xFFFFB74D);
  static const Color infoDark = Color(0xFF4FC3F7);

  // Common Colors (used in both modes)
  static const Color accentColor = Color(0xFFFFD700);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: lightPrimaryColor,
        colorScheme: const ColorScheme.light(
          primary: lightPrimaryColor,
          secondary: accentColor,
          surface: surfaceLight,
          background: backgroundLight,
          error: errorLight,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: textPrimaryLight,
          onBackground: textPrimaryLight,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: cardBackgroundLight,
          foregroundColor: textPrimaryLight,
          elevation: 2,
          shadowColor: Colors.black12,
        ),
        cardTheme: const CardThemeData(
          color: cardBackgroundLight,
          elevation: 2,
          shadowColor: Colors.black12,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightPrimaryColor,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: lightPrimaryColor,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: lightPrimaryColor,
            side: const BorderSide(color: lightPrimaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: dividerLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: dividerLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: lightPrimaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: errorLight),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: errorLight, width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(color: textHintLight),
          labelStyle: const TextStyle(color: textSecondaryLight),
          errorStyle: const TextStyle(color: errorLight),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textPrimaryLight,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimaryLight,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textPrimaryLight,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textPrimaryLight,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textPrimaryLight,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimaryLight,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: textPrimaryLight,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: textSecondaryLight,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: textHintLight,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: textSecondaryLight),
        dividerTheme: const DividerThemeData(
          color: dividerLight,
          thickness: 1,
          space: 1,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: lightPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardBackgroundLight,
          selectedItemColor: lightPrimaryColor,
          unselectedItemColor: textHintLight,
          elevation: 8,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: cardBackgroundLight,
          selectedIconTheme: IconThemeData(color: lightPrimaryColor),
          selectedLabelTextStyle: TextStyle(color: lightPrimaryColor),
          unselectedIconTheme: IconThemeData(color: textHintLight),
          unselectedLabelTextStyle: TextStyle(color: textHintLight),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: lightPrimaryColor,
          circularTrackColor: dividerLight,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: surfaceLight,
          contentTextStyle: TextStyle(color: textPrimaryLight),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: surfaceLight,
          selectedColor: lightPrimaryColor,
          labelStyle: TextStyle(color: textPrimaryLight),
          secondaryLabelStyle: TextStyle(color: Colors.white),
          brightness: Brightness.light,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: lightPrimaryColor,
          unselectedLabelColor: textHintLight,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: lightPrimaryColor, width: 2),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: darkPrimaryColor,
        colorScheme: const ColorScheme.dark(
          primary: darkPrimaryColor,
          secondary: accentColor,
          surface: surfaceDark,
          background: backgroundDark,
          error: errorDark,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: textPrimaryDark,
          onBackground: textPrimaryDark,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: backgroundDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: cardBackgroundDark,
          foregroundColor: textPrimaryDark,
          elevation: 2,
          shadowColor: Colors.black26,
        ),
        cardTheme: const CardThemeData(
          color: cardBackgroundDark,
          elevation: 2,
          shadowColor: Colors.black26,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPrimaryColor,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: darkPrimaryColor,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: darkPrimaryColor,
            side: const BorderSide(color: darkPrimaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: dividerDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: dividerDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: errorDark),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: errorDark, width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(color: textHintDark),
          labelStyle: const TextStyle(color: textSecondaryDark),
          errorStyle: const TextStyle(color: errorDark),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textPrimaryDark,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimaryDark,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textPrimaryDark,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textPrimaryDark,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textPrimaryDark,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimaryDark,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: textPrimaryDark,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: textSecondaryDark,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: textHintDark,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: textSecondaryDark),
        dividerTheme: const DividerThemeData(
          color: dividerDark,
          thickness: 1,
          space: 1,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardBackgroundDark,
          selectedItemColor: darkPrimaryColor,
          unselectedItemColor: textHintDark,
          elevation: 8,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: cardBackgroundDark,
          selectedIconTheme: IconThemeData(color: darkPrimaryColor),
          selectedLabelTextStyle: TextStyle(color: darkPrimaryColor),
          unselectedIconTheme: IconThemeData(color: textHintDark),
          unselectedLabelTextStyle: TextStyle(color: textHintDark),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: darkPrimaryColor,
          circularTrackColor: dividerDark,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: surfaceDark,
          contentTextStyle: TextStyle(color: textPrimaryDark),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: surfaceDark,
          selectedColor: darkPrimaryColor,
          labelStyle: TextStyle(color: textPrimaryDark),
          secondaryLabelStyle: TextStyle(color: Colors.white),
          brightness: Brightness.dark,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: darkPrimaryColor,
          unselectedLabelColor: textHintDark,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: darkPrimaryColor, width: 2),
          ),
        ),
      );
}
