
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final TextTheme _appTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black87),
    displayMedium: GoogleFonts.poppins(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black87),
    displaySmall: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
    headlineLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
    headlineMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87),
    headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
    titleLarge: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87),
    titleMedium: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
    titleSmall: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    bodyLarge: GoogleFonts.openSans(fontSize: 16, color: Colors.black87),
    bodyMedium: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
    bodySmall: GoogleFonts.openSans(fontSize: 12, color: Colors.black87),
    labelLarge: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: GoogleFonts.openSans(fontSize: 12, color: Colors.black87),
    labelSmall: GoogleFonts.openSans(fontSize: 11, color: Colors.black87),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.openSans().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6200EE), // Deep Purple, a vibrant yet professional color
      brightness: Brightness.light,
      primary: const Color(0xFF6200EE), // Primary color
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFBB86FC),
      onPrimaryContainer: Colors.black,
      secondary: const Color(0xFF03DAC6), // Teal accent
      onSecondary: Colors.black,
      secondaryContainer: const Color(0xFF03DAC6),
      onSecondaryContainer: Colors.black,
      tertiary: const Color(0xFF00C853), // Green for success/completion
      onTertiary: Colors.white,
      error: const Color(0xFFB00020), // Red for errors
      onError: Colors.white,
      background: Colors.white, // Pure white background
      onBackground: Colors.black,
      surface: const Color(0xFFFFFFFF), // White surface for cards/sheets
      onSurface: Colors.black,
      surfaceVariant: const Color(0xFFF0F0F0), // Light grey for subtle separation
      onSurfaceVariant: Colors.black54,
      outline: Colors.grey.shade300, // Light grey outline
      shadow: Colors.black.withOpacity(0.1),
      inverseSurface: const Color(0xFF121212),
      onInverseSurface: Colors.white,
      inversePrimary: const Color(0xFFBB86FC),
    ),
    textTheme: _appTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: _appTextTheme.headlineMedium!.copyWith(color: Colors.black87),
      iconTheme: const IconThemeData(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF6200EE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: _appTextTheme.labelLarge,
        elevation: 4, // Multi-layered drop shadow
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF6200EE),
        textStyle: _appTextTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF03DAC6), // Teal accent
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6, // Strong sense of depth
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF7F7F7), // Light grey background for input fields
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6200EE), width: 2),
      ),
      labelStyle: _appTextTheme.bodyMedium!.copyWith(color: Colors.black54),
      hintStyle: _appTextTheme.bodySmall!.copyWith(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      elevation: 8, // Soft, deep shadow to look "lifted"
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.15),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF03DAC6); // Teal when selected
        }
        return Colors.grey.shade400; // Grey when not selected
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: _appTextTheme.bodyMedium!.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    ),
  );
}
