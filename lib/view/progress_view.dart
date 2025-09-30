import 'package:flutter/material.dart';
import '../data/progress_store.dart';

class ProgressView extends StatelessWidget {
  static const route = '/progress';
  const ProgressView({super.key});

  Future<ProgressData> _load() => ProgressStore.read();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: FutureBuilder<ProgressData>(
        future: _load(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.emoji_events_outlined),
                  title: const Text('Quizzes taken'),
                  trailing: Text('${p.quizzesTaken}'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.stacked_bar_chart_rounded),
                  title: const Text('Best score'),
                  subtitle: Text('Out of ${p.bestScoreOutOf}'),
                  trailing: Text('${p.bestScore}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
