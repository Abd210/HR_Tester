// lib/providers/cv_provider.dart

import 'package:flutter/material.dart';
import '../models/cv.dart';
import 'package:uuid/uuid.dart';

class CvProvider with ChangeNotifier {
  List<Cv> _cvs = List.generate(5, (index) => Cv.sampleCv((index + 1).toString()));
  final Uuid _uuid = Uuid();

  List<Cv> get cvs => _cvs;

  void addCv(Cv cv) {
    _cvs.add(cv);
    notifyListeners();
  }

  void removeCv(String id) {
    _cvs.removeWhere((cv) => cv.id == id);
    notifyListeners();
  }

  void updateCv(Cv updatedCv) {
    int index = _cvs.indexWhere((cv) => cv.id == updatedCv.id);
    if (index != -1) {
      _cvs[index] = updatedCv;
      notifyListeners();
    }
  }
}
