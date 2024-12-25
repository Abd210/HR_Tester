// lib/screens/tests/take_test_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/test.dart';
import '../../providers/test_provider.dart';
import '../../widgets/common/sidebar.dart';
import '../../widgets/common/header.dart';

class TakeTestScreen extends StatefulWidget {
  @override
  _TakeTestScreenState createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  int _currentQuestionIndex = 0;
  Map<String, String> _answers = {}; // questionId: selectedOptionId
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);
    final Test? test = testProvider.tests.isNotEmpty ? testProvider.tests.first : null;

    if (test == null) {
      return Scaffold(
        appBar: Header(title: 'Take Test'),
        drawer: Sidebar(),
        body: Center(child: Text('No tests available at the moment.')),
      );
    }

    final TestQuestion currentQuestion = test.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: Header(title: 'Take Test: ${test.title}'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isSubmitted
            ? _buildResultView(test)
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            Text(
              'Question ${_currentQuestionIndex + 1} of ${test.questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),

            // Question Text
            Text(
              currentQuestion.question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),

            // Options
            ...currentQuestion.options.map((option) {
              return RadioListTile<String>(
                title: Text(option.optionText),
                value: option.id,
                groupValue: _answers[currentQuestion.id],
                onChanged: (value) {
                  setState(() {
                    _answers[currentQuestion.id] = value!;
                  });
                },
              );
            }).toList(),
            Spacer(),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentQuestionIndex > 0
                      ? () {
                    setState(() {
                      _currentQuestionIndex--;
                    });
                  }
                      : null,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentQuestionIndex < test.questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                      });
                    } else {
                      // Submit Test
                      setState(() {
                        _isSubmitted = true;
                      });
                    }
                  },
                  child: Text(_currentQuestionIndex < test.questions.length - 1 ? 'Next' : 'Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(Test test) {
    int correctAnswers = 0;
    test.questions.forEach((question) {
      String? selectedOptionId = _answers[question.id];
      if (selectedOptionId != null) {
        TestOption selectedOption = question.options.firstWhere((option) => option.id == selectedOptionId);
        if (selectedOption.isCorrect) correctAnswers++;
      }
    });

    double percentage = (correctAnswers / test.questions.length) * 100;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Test Submitted!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          Text('You answered $correctAnswers out of ${test.questions.length} correctly.', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Text('Score: ${percentage.toStringAsFixed(2)}%', style: TextStyle(fontSize: 22, color: Colors.green)),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tests/summary');
            },
            child: Text('View Summary'),
          ),
        ],
      ),
    );
  }
}
