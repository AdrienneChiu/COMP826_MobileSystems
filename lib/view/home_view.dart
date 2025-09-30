import 'package:flutter/material.dart';
import '../widget/common.dart';
import '../main.dart'; 
import 'learn_view.dart';
import 'progress_view.dart';
import 'parent_dashboard_view.dart';
import 'profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
  automaticallyImplyLeading: false, 
  centerTitle: false,               
  title: const Text(
    'CyberBuddy',
    style: TextStyle(
      fontSize: 32,                 
      fontWeight: FontWeight.w900,  
      letterSpacing: -0.5,
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, ProfileView.route),
        icon: const CircleAvatar(
          radius: 18,
          child: Icon(Icons.person, size: 20),
        ),
        tooltip: 'Profile',
      ),
    ),
  ],
),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
        child: Column(
          children: [
            const TipCard(
              text: "Daily Tip:\nDon't give out your personal details to strangers!",
            ),
            const SizedBox(height: 80),

            // Stacked widget tiles for main pages
            Expanded(
              child: ListView(
                children: [
                  BigColorTile(
                    icon: Icons.sports_esports_rounded,
                    label: 'Learn',
                    background: AppColors.greenTile,
                    onTap: () => Navigator.pushNamed(context, LearnView.route),
                  ),
                  const SizedBox(height: 50),
                  BigColorTile(
                    icon: Icons.emoji_events_rounded,
                    label: 'Progress',
                    background: AppColors.blueTile,
                    onTap: () => Navigator.pushNamed(context, ProgressView.route),
                  ),
                  const SizedBox(height: 50),
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
