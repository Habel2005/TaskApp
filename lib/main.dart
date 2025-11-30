import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Task-it',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.tealAccent,
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1E1E1E),
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context)
                    .primaryTextTheme
                    .apply(bodyColor: Colors.white, displayColor: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white70),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E1E1E),
                elevation: 0,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
              ),
              chipTheme: ChipThemeData(
                backgroundColor: Colors.teal.withOpacity(0.2),
                labelStyle: const TextStyle(color: Colors.tealAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.tealAccent, width: 1),
                ),
              ),
            ),
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
