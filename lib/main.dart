import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/progress_page.dart';
import 'pages/parent_dashboard_page.dart';
import 'pages/profile_page.dart';
import 'pages/quiz_page.dart';
import 'pages/completion_page.dart';

// Colour scheme for App
class AppColors {
  static const bgPeach   = Color(0xFFFFE3B3); // page background
  static const cardWhite = Color(0xFFFFFFFF); // tip card
  static const greenTile = Color(0xFF6BD08C); // Learn
  static const blueTile  = Color(0xFF64B6F7); // Progress
  static const orangeTile= Color(0xFFFFB74D); // Parent Dashboard

  static const textDark  = Color(0xFF111827); // near-black
}

// App Theme
ThemeData _theme() {
  final base = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bgPeach,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.greenTile,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.cardWhite,
      background: AppColors.bgPeach,
      onSurface: AppColors.textDark,
      primaryContainer: AppColors.greenTile,
      onPrimaryContainer: AppColors.textDark,
    ),
  );

  // Base theme - text
  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textDark,
      titleTextStyle: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5,
      ).copyWith(color: AppColors.textDark),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardWhite,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      shadowColor: Colors.black.withOpacity(0.06),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CyberBuddyApp());
}

// Main App Widget
class CyberBuddyApp extends StatelessWidget {
  const CyberBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberBuddy',
      theme: _theme(),
      routes: {
        '/': (_) => const HomePage(),
        LearnPage.route: (_) => const LearnPage(),
        ProgressPage.route: (_) => const ProgressPage(),
        ParentDashboardPage.route: (_) => const ParentDashboardPage(),
        ProfilePage.route: (_) => const ProfilePage(),
        QuizPage.route: (_) => const QuizPage(),
        CompletionPage.route: (_) => const CompletionPage(),
      },
      initialRoute: '/',
    );
  }
}
