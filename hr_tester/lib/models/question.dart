// lib/models/question.dart

enum QuestionCoefficient { Easy, Medium, Hard }

class Question {
  final String id;
  final String text;
  final List<Answer> answers;
  final QuestionCoefficient coefficient;
  final List<String> correctAnswerIds;
  final String nextDomain;

  Question({
    required this.id,
    required this.text,
    required this.answers,
    required this.coefficient,
    required this.correctAnswerIds,
    required this.nextDomain,
  });

  factory Question.sampleQuestion(String id) {
    int numericId = int.parse(id.split('-').last);
    return Question(
      id: id,
      text: 'What is the purpose of question $id?',
      answers: List.generate(
        4,
            (index) => Answer.sampleAnswer('${id}-o$index'),
      ),
      coefficient: QuestionCoefficient.values[numericId % 3],
      correctAnswerIds: ['${id}-o0'], // First option is correct
      nextDomain: ['Engineering', 'Human Resources', 'Marketing', 'Sales'][numericId % 4],
    );
  }
}

class Answer {
  final String id;
  final String text;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.text,
    this.isCorrect = false,
  });

  factory Answer.sampleAnswer(String id) {
    // Extract the last segment after splitting by '-'
    String lastPart = id.split('-').last; // e.g., 'o0'

    // Remove non-numeric characters to extract the numeric part
    String numericString = lastPart.replaceAll(RegExp(r'[^0-9]'), ''); // Extract '0'

    // Parse the numeric string to an integer
    int numericValue = int.parse(numericString); // Convert '0' to 0

    return Answer(
      id: id,
      text: 'Option ${numericValue + 1}', // Correctly add 1 to the number
      isCorrect: id.endsWith('0'), // First option is correct
    );
  }
}
