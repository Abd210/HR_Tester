// lib/models/cv.dart

class Cv {
  final String id;
  final String candidateName;
  final String email;
  final String domain;
  final String resumeUrl;
  final List<DomainDetail> details;
  final List<TestResult> testResults;

  Cv({
    required this.id,
    required this.candidateName,
    required this.email,
    required this.domain,
    required this.resumeUrl,
    required this.details,
    required this.testResults,
  });

  // Factory method to generate static CVs
  factory Cv.sampleCv(String id) {
    return Cv(
      id: id,
      candidateName: 'Candidate $id',
      email: 'candidate$id@example.com',
      domain: ['Engineering', 'Human Resources', 'Marketing', 'Sales'][int.parse(id) % 4],
      resumeUrl: 'https://example.com/resume$id.pdf',
      details: [
        DomainDetail(detailType: 'Foreign Languages', detailValue: 'English, French'),
        DomainDetail(detailType: 'Driving License', detailValue: 'B Category'),
        DomainDetail(detailType: 'PC Skills', detailValue: 'Advanced'),
        // Add more details as needed
      ],
      testResults: [],
    );
  }
}

class DomainDetail {
  final String detailType;
  final String detailValue;

  DomainDetail({
    required this.detailType,
    required this.detailValue,
  });
}

class TestResult {
  final String testId;
  final double score;
  final String feedback;

  TestResult({
    required this.testId,
    required this.score,
    required this.feedback,
  });
}
