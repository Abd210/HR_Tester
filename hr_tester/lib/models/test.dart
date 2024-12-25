// lib/models/test.dart

enum QuestionCoefficient { Easy, Medium, Hard }

class Test {
  final String id;
  final String title;
  final String domain;
  final DateTime createdDate;
  final List<TestQuestion> questions;
  final bool isActive;

  Test({
    required this.id,
    required this.title,
    required this.domain,
    required this.createdDate,
    required this.questions,
    required this.isActive,
  });

  // Factory method to generate static tests
  factory Test.sampleTest(String id) {
    // Attempt to parse the id to an integer; default to 0 if parsing fails
    int numericId = int.tryParse(id) ?? 0;

    return Test(
      id: id,
      title: 'Test Title $id',
      domain: ['Engineering', 'HR', 'Marketing'][numericId % 3],
      createdDate: DateTime.now().subtract(Duration(days: numericId)),
      questions: List.generate(
        10,
            (index) => TestQuestion.sampleQuestion('$id-$index'),
      ),
      isActive: numericId % 2 == 0,
    );
  }
}

class TestQuestion {
  final String id;
  final String question;
  final List<TestOption> options;
  final QuestionCoefficient coefficient;

  TestQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.coefficient,
  });

  // Factory method to generate static questions
  factory TestQuestion.sampleQuestion(String id) {
    // Extract the question index from the id
    // Assuming id format is 'testIndex-questionIndex', e.g., '1-0'
    List<String> parts = id.split('-');
    int questionIndex = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    return TestQuestion(
      id: id,
      question: 'What is the purpose of question $id?',
      options: List.generate(
        4,
            (index) => TestOption(
          id: '$id-o$index',
          optionText: 'Option ${index + 1}',
          isCorrect: index == 0,
        ),
      ),
      coefficient: QuestionCoefficient.values[questionIndex % 3],
    );
  }
}

class TestOption {
  final String id;
  final String optionText;
  final bool isCorrect;

  TestOption({
    required this.id,
    required this.optionText,
    this.isCorrect = false,
  });
}
