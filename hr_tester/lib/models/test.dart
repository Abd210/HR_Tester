// lib/models/test.dart

import 'question.dart';

class TestModel {
  final String id;
  final String title;
  final String domainId;
  final DateTime createdDate;
  final List<Question> questions;
  final bool isActive;

  TestModel({
    required this.id,
    required this.title,
    required this.domainId,
    required this.createdDate,
    required this.questions,
    required this.isActive,
  });

  factory TestModel.sampleTest(String id) {
    return TestModel(
      id: id,
      title: 'Test Title $id',
      domainId: ['1', '2', '3', '4'][int.parse(id) % 4], // Assuming domain IDs 1-4
      createdDate: DateTime.now().subtract(Duration(days: int.parse(id))),
      questions: List.generate(10, (index) => Question.sampleQuestion('$id-$index')),
      isActive: int.parse(id) % 2 == 0,
    );
  }
}
