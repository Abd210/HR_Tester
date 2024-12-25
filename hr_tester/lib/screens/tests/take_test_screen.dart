// lib/screens/tests/take_test_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/test_provider.dart';
import '../../models/test.dart';
import '../../models/question.dart';
import '../common/sidebar.dart';
import '../../widgets/common/header.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../common/sidebar.dart';

class TakeTestScreen extends StatefulWidget {
  @override
  _TakeTestScreenState createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  int _currentQuestionIndex = 0;
  Map<String, List<String>> _answers = {}; // questionId: List of selectedOptionIds
  bool _isSubmitted = false;
  late CameraController _cameraController;
  late Future<void> _initializeCameraFuture;
  bool _isCameraInitialized = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      _initializeCameraFuture = _cameraController.initialize();
      await _initializeCameraFuture;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _toggleAnswer(String questionId, String optionId) {
    setState(() {
      if (_answers.containsKey(questionId)) {
        if (_answers[questionId]!.contains(optionId)) {
          _answers[questionId]!.remove(optionId);
        } else {
          _answers[questionId]!.add(optionId);
        }
      } else {
        _answers[questionId] = [optionId];
      }
    });
  }

  void _submitTest(BuildContext context, TestModel test) {
    setState(() {
      _isSubmitted = true;
    });

    // Calculate score based on coefficients and correct answers
    double totalScore = 0;
    double maxScore = 0;

    for (var question in test.questions) {
      maxScore += _getCoefficientValue(question.coefficient);
      if (_answers.containsKey(question.id)) {
        List<String> selected = _answers[question.id]!;
        List<String> correct = question.correctAnswerIds;
        if (selected.toSet().containsAll(correct.toSet()) && correct.toSet().containsAll(selected.toSet())) {
          totalScore += _getCoefficientValue(question.coefficient);
        }
      }
    }

    double percentage = (totalScore / maxScore) * 100;

    // Navigate to Test Results Screen with the score and answers
    Navigator.pushReplacementNamed(
      context,
      '/tests/results',
      arguments: {'score': percentage, 'testId': test.id, 'answers': _answers},
    );
  }

  double _getCoefficientValue(QuestionCoefficient coefficient) {
    switch (coefficient) {
      case QuestionCoefficient.Easy:
        return 1.0;
      case QuestionCoefficient.Medium:
        return 2.0;
      case QuestionCoefficient.Hard:
        return 3.0;
      default:
        return 1.0;
    }
  }

  Future<void> _capturePhoto() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
        // Save or process the captured image as needed
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);
    final TestModel? test = testProvider.tests.isNotEmpty ? testProvider.tests.first : null;

    if (test == null) {
      return Scaffold(
        appBar: Header(title: 'Take Test'),
        drawer: Sidebar(),
        body: Center(child: Text('No tests available at the moment.')),
      );
    }

    if (_isSubmitted) {
      return Center(child: CircularProgressIndicator());
    }

    final Question currentQuestion = test.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: Header(title: 'Take Test: ${test.title}'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Webcam Preview
            _isCameraInitialized
                ? Container(
              height: 200,
              child: CameraPreview(_cameraController),
            )
                : Container(
              height: 200,
              color: Colors.black12,
              child: Center(child: Text('Initializing camera...')),
            ),
            SizedBox(height: 16),

            // Capture Photo Button
            ElevatedButton.icon(
              onPressed: _capturePhoto,
              icon: Icon(Icons.camera_alt),
              label: Text('Capture Photo'),
            ),
            SizedBox(height: 16),
            _capturedImage != null
                ? Image.file(
              File(_capturedImage!.path),
              height: 100,
            )
                : Container(),
            SizedBox(height: 16),

            // Question Header
            Text(
              'Question ${_currentQuestionIndex + 1} of ${test.questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),

            // Question Text
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),

            // Coefficient Note
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text('Difficulty: ${describeEnum(currentQuestion.coefficient)}'),
                backgroundColor: _getCoefficientColor(currentQuestion.coefficient),
              ),
            ),
            SizedBox(height: 16),

            // Options
            Expanded(
              child: ListView(
                children: currentQuestion.answers.map((option) {
                  bool isSelected = _answers[currentQuestion.id]?.contains(option.id) ?? false;
                  return CheckboxListTile(
                    title: Text(option.text),
                    value: isSelected,
                    onChanged: (bool? value) {
                      _toggleAnswer(currentQuestion.id, option.id);
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),

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
                      _submitTest(context, test);
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

  Color _getCoefficientColor(QuestionCoefficient coefficient) {
    switch (coefficient) {
      case QuestionCoefficient.Easy:
        return Colors.green;
      case QuestionCoefficient.Medium:
        return Colors.orange;
      case QuestionCoefficient.Hard:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
