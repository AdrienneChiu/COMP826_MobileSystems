import 'package:flutter/material.dart';

// Views
import 'view/home_view.dart';
import 'view/learn_view.dart';
import 'view/progress_view.dart';
import 'view/parent_dashboard_view.dart';
import 'view/profile_view.dart';
import 'view/quiz_view.dart';
import 'view/completion_view.dart';

// Colour scheme for App
class AppColors {
  static const bgPeach   = Color(0xFFFFE3B3); // Page background
  static const cardWhite = Color(0xFFFFFFFF); // Tip card
  static const greenTile = Color(0xFF6BD08C); // Learn
  static const blueTile  = Color(0xFF64B6F7); // Progress
  static const orangeTile= Color(0xFFFFB74D); // Parent Dashboard

  static const textDark  = Color(0xFF111827); // Primary text colour
}

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

class CyberBuddyApp extends StatelessWidget {
  const CyberBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberBuddy',
      theme: _theme(),
      routes: {
        '/': (_) => const HomePage(),
        LearnView.route: (_) => const LearnView(),
        ProgressView.route: (_) => const ProgressView(),
        ParentDashboardView.route: (_) => const ParentDashboardView(),
        ProfileView.route: (_) => const ProfileView(),
        QuizView.route: (_) => const QuizView(),
        CompletionView.route: (_) => const CompletionView(),
      },
      initialRoute: '/',
    );
  }
}
