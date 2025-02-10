import 'package:flutter/material.dart';

/// All custom application themes
class AppTheme {
  /// Default application theme
  static ThemeData get basic => ThemeData(
        fontFamily: 'Helvetica, Arial, sans-serif', // Facebook-like font
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1877F2), // Facebook blue
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xFF1877F2), // Facebook blue
          secondary: const Color(0xFF4267B2), // Darker blue
          surface: const Color(0xFFE7F3FF), // Light blue surface
          error: const Color(0xFFCF6679),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5), // Light background
        cardColor: const Color(0xFFFFFFFF), // White card color
        canvasColor: const Color(0xFFF0F2F5), // Light background
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1877F2), // Facebook blue
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF1877F2), // Facebook blue
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1877F2), // Facebook blue
            side: const BorderSide(color: Color(0xFF1877F2)), // Facebook blue
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFE7F3FF), // Light blue surface
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color(0xFF1877F2)), // Facebook blue
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1877F2), // Facebook blue
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Color(0xFF1877F2)), // Facebook blue
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          headlineSmall: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 14, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 12, color: Colors.black87),
        ),
      );

  /// Dark mode application theme
  static ThemeData get dark => ThemeData(
        fontFamily: 'Helvetica, Arial, sans-serif', // Facebook-like font
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1877F2), // Facebook blue
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF1877F2), // Facebook blue
          secondary: const Color(0xFF4267B2), // Darker blue
          surface: const Color(0xFF242526), // Dark surface
          error: const Color(0xFFCF6679),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFF18191A), // Dark background
        cardColor: const Color(0xFF242526), // Dark card color
        canvasColor: const Color(0xFF18191A), // Dark background
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1877F2), // Facebook blue
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF1877F2), // Facebook blue
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1877F2), // Facebook blue
            side: const BorderSide(color: Color(0xFF1877F2)), // Facebook blue
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF3A3B3C), // Dark surface
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color(0xFF1877F2)), // Facebook blue
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF242526), // Dark surface
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Color(0xFF1877F2)), // Facebook blue
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
