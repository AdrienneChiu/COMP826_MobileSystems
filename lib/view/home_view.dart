// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../widget/common.dart';
import '../main.dart';
import '../data/tips.dart';
import 'learn_view.dart';
import 'progress_view.dart';
import 'parent_dashboard_view.dart';
import 'profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _tipIndex;

  @override
  void initState() {
    super.initState();
    _tipIndex = _indexForToday();
  }

  int _indexForToday() {
    // Deterministic “tip of the day” — no storage required
    final days = DateTime.now().difference(DateTime(2020, 1, 1)).inDays;
    return days % cyberSafetyTips.length;
  }

  void _nextTip() {
    setState(() {
      _tipIndex = (_tipIndex + 1) % cyberSafetyTips.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'CyberBuddy',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, ProfileView.route),
              icon: const CircleAvatar(
                radius: 16,
                child: Icon(Icons.person, size: 18),
              ),
              tooltip: 'Profile',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 16),
        child: Column(
          children: [
            TipCard(
              text: cyberSafetyTips[_tipIndex],
              onNext: _nextTip, // tap the refresh icon to see another tip
            ),
            const SizedBox(height: 80), // gap between tip and tiles
            Expanded(
              child: ListView(
                children: [
                  BigColorTile(
                    icon: Icons.school_rounded,
                    label: 'Learn',
                    background: AppColors.greenTile,
                    onTap: () => Navigator.pushNamed(context, LearnView.route),
                  ),
                  const SizedBox(height: 40),
                  BigColorTile(
                    icon: Icons.emoji_events_rounded,
                    label: 'Progress',
                    background: AppColors.blueTile,
                    onTap: () => Navigator.pushNamed(context, ProgressView.route),
                  ),
                  const SizedBox(height: 40),
                  BigColorTile(
                    icon: Icons.lock_rounded,
                    label: 'Parent Dashboard',
                    background: AppColors.orangeTile,
                    onTap: () => Navigator.pushNamed(context, ParentDashboardView.route),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
