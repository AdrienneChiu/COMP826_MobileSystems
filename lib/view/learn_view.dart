import 'package:flutter/material.dart';
import '../main.dart';
import 'quiz_view.dart';

class LearnView extends StatelessWidget {
  static const route = '/learn';
  const LearnView({super.key});

  void _soon(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Learn',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pick a Module to Start Learning!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                _ActionTile(
                  color: AppColors.greenTile,
                  icon: Icons.checklist_rounded,
                  title: 'Quizzes',
                  subtitle: 'Safe Chat Simulator',
                  onTap: () => Navigator.pushNamed(context, QuizView.route),
                ),
                const SizedBox(height: 60),

                // Fixed-height tiles (stay in place, not stretched)
                _ActionTile(
                  color: AppColors.blueTile,
                  icon: Icons.sports_esports_rounded,
                  title: 'Games',
                  subtitle: 'Mini games to learn safely',
                  onTap: () => _soon(context, 'Games'),
                ),
                const SizedBox(height: 60),

                

                _ActionTile(
                  color: AppColors.orangeTile,
                  icon: Icons.menu_book_rounded,
                  title: 'Story',
                  subtitle: 'Short stories about safety',
                  onTap: () => _soon(context, 'Story'),
                ),

                const SizedBox(height: 24),
                Text(
                  'Tip: Start with the quiz to practice safe chatting!',
                  style: text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact, colorful tile (fixed height)
class _ActionTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double tileHeight = 88;   // adjust to taste (82–96 looks good)
    const double radius = 22;
    const double badge = 54;        // white icon badge
    const double iconSize = 30;

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Ink(
        height: tileHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Container(
                width: badge,
                height: badge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: iconSize, color: Colors.black87),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
