import 'package:flutter/material.dart';
import '../main.dart'; // for AppColors

class TipCard extends StatelessWidget {
  final String text;
  const TipCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // little bulb badge
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.bgPeach.withOpacity(.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('💡', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18, height: 1.35, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rounded, colorful action tile (used on Home)
class BigColorTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final VoidCallback onTap;

  const BigColorTile({
    super.key,
    required this.icon,
    required this.label,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.3,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 28, color: Colors.black87),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(label, style: textStyle)),
              const Icon(Icons.chevron_right_rounded, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
