import 'package:flutter/material.dart';

class ParentDashboardPage extends StatelessWidget {
  static const route = '/parent';
  const ParentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'No personal data is collected. Progress is stored locally on this device.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text('Tips for adults:'),
          SizedBox(height: 8),
          Text('• Talk about not sharing personal info online.'),
          Text('• Encourage reporting/blocking suspicious contacts.'),
          Text('• Help set long, unique passwords.'),
        ],
      ),
    );
  }
}
