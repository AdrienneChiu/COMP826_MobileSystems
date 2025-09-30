import 'package:flutter/material.dart';
import 'quiz_page.dart';

class LearnPage extends StatelessWidget {
  static const route = '/learn';
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Pick a Module to Start Learning !',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Quiz button
            FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, QuizPage.route),
              icon: const Icon(Icons.quiz_outlined),
              label: const Text('Take Quiz'),
            ),

            const SizedBox(height: 16),

            // Game button (for report/demo purposes only)
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Game coming soon!')),
                );
              },
              icon: const Icon(Icons.videogame_asset_rounded),
              label: const Text('Play Game'),
            ),

            const SizedBox(height: 16),

            // Story button (for report/demo purposes only)
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Story mode coming soon!')),
                );
              },
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text('Read Story'),
            ),

            const SizedBox(height: 24),

            const Text(
              'Coming soon: More lessons on strong passwords, phishing, and privacy.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
