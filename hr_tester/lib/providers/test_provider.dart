// lib/providers/test_provider.dart

import 'package:flutter/material.dart';
import '../models/test.dart';
import 'package:uuid/uuid.dart';

class TestProvider with ChangeNotifier {
  List<TestModel> _tests = List.generate(5, (index) => TestModel.sampleTest((index + 1).toString()));
  final Uuid _uuid = Uuid();

  List<TestModel> get tests => _tests;

  void addTest(TestModel test) {
    _tests.add(test);
    notifyListeners();
  }

  void removeTest(String id) {
    _tests.removeWhere((test) => test.id == id);
    notifyListeners();
  }

  void updateTest(TestModel updatedTest) {
    int index = _tests.indexWhere((test) => test.id == updatedTest.id);
    if (index != -1) {
      _tests[index] = updatedTest;
      notifyListeners();
    }
  }
}
