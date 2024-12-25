// lib/screens/user/salary_suggestions_screen.dart
import 'package:flutter/material.dart';

class SalarySuggestionsScreen extends StatelessWidget {
  final double suggestedSalary = 60000.0;
  final double evolutionBonus = 5000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salary Suggestions')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Based on your evaluations, your suggested salary is:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '\$${suggestedSalary.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Evolution Bonus: \$${evolutionBonus.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement download or print functionality
              },
              child: Text('Download Report'),
            ),
          ],
        ),
      ),
    );
  }
}
