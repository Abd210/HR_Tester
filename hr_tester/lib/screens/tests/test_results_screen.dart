// lib/screens/tests/test_results_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/test_provider.dart';
import '../../models/test.dart';
import '../../models/question.dart';
import '../../widgets/common/header.dart';
import '../common/sidebar.dart';

class TestResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from TakeTestScreen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extract required arguments with proper type casting
    final double score = args['score'] as double;
    final String testId = args['testId'] as String;
    final Map<String, List<String>> answers = Map<String, List<String>>.from(args['answers'] as Map);

    final testProvider = Provider.of<TestProvider>(context, listen: false);
    TestModel? test;

    // Attempt to find the test by testId
    try {
      test = testProvider.tests.firstWhere((t) => t.id == testId);
    } catch (e) {
      // If no test is found, test remains null
      test = null;
    }

    // If test is not found, display an error message
    if (test == null) {
      return Scaffold(
        appBar: Header(title: 'Test Results'),
        drawer: Sidebar(),
        body: Center(
          child: Text(
            'Test not found.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Header(title: 'Test Results'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Overall Score Card
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${score.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Performance: ${_getPerformance(score)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Detailed Results Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detailed Results',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),

            // Expanded List of Detailed Results
            Expanded(
              child: ListView.builder(
                itemCount: test.questions.length,
                itemBuilder: (context, index) {
                  final Question question = test!.questions[index];
                  final List<String> userSelectedAnswers = answers[question.id] ?? [];

                  // Get correct answers
                  final List<String> correctAnswers = question.correctAnswerIds;

                  // Determine if user is correct
                  bool isCorrect = _checkAnswer(question, userSelectedAnswers);

                  return Card(
                    color: isCorrect ? Colors.green[50] : Colors.red[50],
                    child: ListTile(
                      leading: Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      title: Text(question.text),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Answers: ${_formatAnswers(userSelectedAnswers)}'),
                          Text('Correct Answers: ${_formatAnswers(correctAnswers)}'),
                          Text('Coefficient: ${describeEnum(question.coefficient)}'),
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
                    // Navigate back to take test
                    Navigator.pushReplacementNamed(context, '/tests/take');
                  },
                  child: Text('Retake Test'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement download report functionality
                    // For now, show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Report Downloaded')),
                    );
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

  // Helper method to determine performance based on score
  String _getPerformance(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 75) return 'Good';
    if (score >= 50) return 'Average';
    return 'Needs Improvement';
  }

  // Helper method to check if the user's answers are correct
  bool _checkAnswer(Question question, List<String> userAnswers) {
    return userAnswers.toSet().containsAll(question.correctAnswerIds.toSet()) &&
        question.correctAnswerIds.toSet().containsAll(userAnswers.toSet());
  }

  // Helper method to format answers for display
  String _formatAnswers(List<String> answers) {
    return answers.join(', ').isNotEmpty ? answers.join(', ') : 'No Answer';
  }
}
