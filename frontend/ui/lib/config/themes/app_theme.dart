import 'package:flutter/material.dart';

/// All custom application themes
class AppTheme {
  /// Default application theme
  static ThemeData get basic => ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E1E2C),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF1E1E2C),
          secondary: const Color(0xFFFF6584),
          surface: const Color(0xFF2A2A40),
          // Replaced background with surface
          error: const Color(0xFFCF6679),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white, // Deprecated
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
        cardColor: const Color(0xFF2A2A40),
        canvasColor: const Color(0xFF1E1E2C),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF6C63FF),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF6C63FF),
            side: const BorderSide(color: Color(0xFF6C63FF)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E2C),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          headlineMedium: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          headlineSmall: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          titleSmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 14, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      );
}
