// lib/providers/test_provider.dart

import 'package:flutter/material.dart';
import '../models/test.dart';

class TestProvider with ChangeNotifier {
  List<Test> _tests = List.generate(10, (index) => Test.sampleTest((index + 1).toString()));

  List<Test> get tests => _tests;

  void addTest(Test test) {
    _tests.add(test);
    notifyListeners();
  }

  void removeTest(String id) {
    _tests.removeWhere((test) => test.id == id);
    notifyListeners();
  }

  void updateTest(Test updatedTest) {
    int index = _tests.indexWhere((test) => test.id == updatedTest.id);
    if (index != -1) {
      _tests[index] = updatedTest;
      notifyListeners();
    }
  }
}
