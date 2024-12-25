// lib/screens/user/evaluations_screen.dart
import 'package:flutter/material.dart';

class EvaluationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> evaluations = [
    {
      'date': '2024-12-01',
      'score': 85,
      'feedback': 'Excellent performance in technical skills.',
    },
    {
      'date': '2024-06-15',
      'score': 75,
      'feedback': 'Good overall, but needs improvement in communication.',
    },
    // Add more evaluations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evaluations')),
      body: ListView.builder(
        itemCount: evaluations.length,
        itemBuilder: (context, index) {
          final eval = evaluations[index];
          return Card(
            child: ListTile(
              title: Text('Date: ${eval['date']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Score: ${eval['score']}'),
                  Text('Feedback: ${eval['feedback']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
