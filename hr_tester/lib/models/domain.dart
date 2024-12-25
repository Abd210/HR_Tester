// lib/models/domain.dart

import 'package:hr_tester/models/question.dart';

class Domain {
  final String id;
  final String name;
  final List<Question> questions;
  final int coefficient;

  Domain({
    required this.id,
    required this.name,
    required this.questions,
    required this.coefficient,
  });

  factory Domain.sampleDomain(String id) {
    return Domain(
      id: id,
      name: ['Engineering', 'Human Resources', 'Marketing', 'Sales'][int.parse(id) % 4],
      questions: List.generate(10, (index) => Question.sampleQuestion('$id-$index')),
      coefficient: 1 + (int.parse(id) % 3), // 1=Easy, 2=Medium, 3=Hard
    );
  }
}
