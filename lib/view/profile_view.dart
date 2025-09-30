import 'package:flutter/material.dart';
import '../data/progress_store.dart';

class ProfileView extends StatefulWidget {
  static const route = '/profile';
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<ProgressData> _load() => ProgressStore.read();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<ProgressData>(
        future: _load(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Card(
                  color: cs.secondaryContainer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: const ListTile(
                    leading: CircleAvatar(radius: 24, child: Icon(Icons.child_care)),
                    title: Text('Player'),
                    subtitle: Text('No personal data stored'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Progress Overview'),
                        subtitle: Text(
                          'Quizzes taken: ${data.quizzesTaken}\nBest score: ${data.bestScore} / ${data.bestScoreOutOf}',
                        ),
                      ),
                      const Divider(height: 0),
                      SwitchListTile(
                        title: const Text('Sound Effects'),
                        value: data.soundOn,
                        onChanged: (v) async {
                          await ProgressStore.setSound(v);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    await ProgressStore.reset();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Progress reset')),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Progress'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
