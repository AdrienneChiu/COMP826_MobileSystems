import 'package:flutter/material.dart';

// Arguments passed to CompletionPage
class CompletionArgs {
  final int score;
  final int total;
  const CompletionArgs({required this.score, required this.total});
}

class CompletionPage extends StatelessWidget {
  static const route = '/completion';
  const CompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as CompletionArgs? ??
        const CompletionArgs(score: 0, total: 0);
    final cs = Theme.of(context).colorScheme;
    final success = args.total > 0 && args.score >= (args.total * 0.6);

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Complete')),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.info_outline,
                  size: 64,
                  color: success ? cs.primary : cs.tertiary,
                ),
                const SizedBox(height: 12),
                Text(
                  success ? 'You Got It Right!' : 'Nice Try!',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text('Score: ${args.score} / ${args.total}'),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () =>
                      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                  child: const Text('Back To Menu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
