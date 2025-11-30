import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final TextTheme _appTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 57,
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade900,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade900,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade900,
    ),
    headlineLarge: GoogleFonts.manrope(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade900,
    ),
    headlineMedium: GoogleFonts.manrope(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade900,
    ),
    headlineSmall: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade900,
    ),
    titleLarge: GoogleFonts.manrope(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade900,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade900,
    ),
    titleSmall: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade900,
    ),
    bodyLarge: GoogleFonts.inter(fontSize: 16, color: Colors.grey.shade800),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: Colors.grey.shade800),
    bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade700),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade700),
    labelSmall: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF), // A soft, modern violet
      brightness: Brightness.light,
      primary: const Color(0xFF6C63FF),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFE0DFFF),
      onPrimaryContainer: Colors.grey.shade900,
      secondary: const Color(0xFF00C853), // A fresh green
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFB9F6CA),
      onSecondaryContainer: Colors.grey.shade900,
      tertiary: const Color(0xFFFFAB40), // An energetic orange
      onTertiary: Colors.white,
      error: const Color(0xFFEF5350), // A gentle red for errors
      onError: Colors.white,
      background: const Color(0xFFF5F7FA), // Light, subtle background
      onBackground: Colors.grey.shade900,
      surface: const Color(0xFFFFFFFF), // Crisp white surface
      onSurface: Colors.grey.shade900,
      surfaceVariant: const Color(
        0xFFE8ECF1,
      ), // Slightly darker grey for subtle separation
      onSurfaceVariant: Colors.grey.shade700,
      outline: Colors.grey.shade300,
      shadow: Colors.black.withOpacity(0.08),
      inverseSurface: Colors.grey.shade900,
      onInverseSurface: Colors.white,
      inversePrimary: const Color(0xFFBBDEFB),
    ),
    textTheme: _appTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFF5F7FA),
      foregroundColor: Colors.grey.shade900,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: _appTextTheme.headlineSmall!.copyWith(
        color: Colors.grey.shade900,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: Colors.grey.shade700),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF6C63FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ), // More rounded
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        textStyle: _appTextTheme.labelLarge,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF6C63FF),
        textStyle: _appTextTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF00C853),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ), // Rounded square FAB
      elevation: 8,
      highlightElevation: 12,
      splashColor: Colors.white.withOpacity(0.2),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // White background for input fields
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
        borderSide: const BorderSide(
          color: Color(0xFF6C63FF),
          width: 2,
        ), // Primary color highlight
      ),
      labelStyle: _appTextTheme.bodyMedium!.copyWith(
        color: Colors.grey.shade600,
      ),
      hintStyle: _appTextTheme.bodySmall!.copyWith(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
    cardTheme: CardThemeData(
      elevation: 10, // Stronger, multi-layered shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ), // Very rounded corners
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.18),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF00C853); // Fresh green when selected
        }
        return Colors.grey.shade300; // Lighter grey when not selected
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ), // Slightly rounded checkbox
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade900,
      contentTextStyle: _appTextTheme.bodyMedium!.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 8,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6C63FF),
      unselectedItemColor: Colors.grey.shade500,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: _appTextTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: _appTextTheme.labelSmall,
    ),
  );
}
