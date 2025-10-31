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
  String? _editedName; // local override until saved

  Future<void> _editName(BuildContext context, String current) async {
    final controller = TextEditingController(text: current);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Edit Name"),
          content: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: "Enter your name",
              border: OutlineInputBorder(),
            ),
            onSubmitted: (val) => Navigator.pop(context, val.trim()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      await ProgressStore.setPlayerName(newName);
      setState(() => _editedName = newName); // reflect immediately
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name saved')),
        );
      }
    }
  }

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
          final displayName = _editedName ?? data.playerName; // show saved name

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Card(
                  color: cs.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.child_care),
                    ),
                    title: Text(
                      displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('No personal data stored'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit Name',
                      onPressed: () => _editName(context, displayName),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: const Text('Progress Overview'),
                    subtitle: Text(
                      'Quizzes taken: ${data.quizzesTaken}\n'
                      'Best score: ${data.bestScore} / ${data.bestScoreOutOf}',
                    ),
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
                    setState(() {
                      // keep name; only progress is reset
                    });
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
