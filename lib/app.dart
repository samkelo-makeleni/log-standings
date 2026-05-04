import 'package:flutter/material.dart';

import 'views/standings_screen.dart';

class LogStandingsApp extends StatelessWidget {
  const LogStandingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF17944A);
    const brandGreenDark = Color(0xFF0B5D2A);
    const brandGreenSoft = Color(0xFFE7F6EC);

    return MaterialApp(
      title: 'TSHWANE REGIONAL FOOTBALL ASSOCIATION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4FBF6),
        appBarTheme: const AppBarTheme(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: brandGreenSoft,
          indicatorColor: const Color(0xFFCBECD6),
          labelTextStyle: WidgetStatePropertyAll(
            const TextStyle(
              color: brandGreenDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: WidgetStatePropertyAll(
            const IconThemeData(color: brandGreenDark),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: brandGreenDark.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: brandGreenDark.withValues(alpha: 0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: brandGreenDark, width: 1.4),
          ),
        ),
        useMaterial3: true,
      ),
      home: const StandingsScreen(),
    );
  }
}
