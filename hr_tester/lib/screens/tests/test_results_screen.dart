// lib/screens/tests/test_results_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/common/sidebar.dart';
import '../../widgets/common/header.dart';

class TestResultsScreen extends StatelessWidget {
  final int totalScore = 85;
  final int maxScore = 100;
  final List<Map<String, dynamic>> detailedResults = List.generate(
    10,
        (index) => {
      'question': 'Question ${index + 1}',
      'yourAnswer': 'Option A',
      'correctAnswer': 'Option B',
      'isCorrect': index % 2 == 0,
    },
  );

  @override
  Widget build(BuildContext context) {
    double percentage = (totalScore / maxScore) * 100;

    return Scaffold(
      appBar: Header(title: 'Test Results'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Overall Score
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text('Your Score', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('$totalScore / $maxScore', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('${percentage.toStringAsFixed(2)}%', style: TextStyle(fontSize: 24, color: Colors.green)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Detailed Results
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detailed Results',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: detailedResults.length,
                itemBuilder: (context, index) {
                  final result = detailedResults[index];
                  return Card(
                    color: result['isCorrect'] ? Colors.green[50] : Colors.red[50],
                    child: ListTile(
                      leading: Icon(
                        result['isCorrect'] ? Icons.check_circle : Icons.cancel,
                        color: result['isCorrect'] ? Colors.green : Colors.red,
                      ),
                      title: Text(result['question']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Answer: ${result['yourAnswer']}'),
                          Text('Correct Answer: ${result['correctAnswer']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to tests
                    Navigator.pop(context);
                  },
                  child: Text('Back to Tests'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement download report functionality
                    // For now, show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report Downloaded')));
                  },
                  child: Text('Download Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
