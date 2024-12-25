// lib/screens/tests/test_summary_screen.dart
import 'package:flutter/material.dart';

class TestSummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> summary = [
    {
      'question': 'What is Flutter?',
      'yourAnswer': 'A programming language',
      'correctAnswer': 'A UI toolkit',
    },
    // Add more summary items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Summary')),
      body: ListView.builder(
        itemCount: summary.length,
        itemBuilder: (context, index) {
          final item = summary[index];
          return Card(
            child: ListTile(
              title: Text(item['question']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Answer: ${item['yourAnswer']}'),
                  Text('Correct Answer: ${item['correctAnswer']}'),
                ],
              ),
              trailing: item['yourAnswer'] == item['correctAnswer']
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.close, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
