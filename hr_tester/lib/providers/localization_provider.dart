// lib/providers/localization_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class LocalizationProvider with ChangeNotifier {
  Locale _currentLocale = Locale('en', '');

  Locale get currentLocale => _currentLocale;

  Map<String, String> _localizedStrings = {};

  Map<String, String> get localizedStrings => _localizedStrings;

  Future<void> loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('lib/localization/${_currentLocale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    notifyListeners();
  }

  void changeLocale(Locale locale) {
    _currentLocale = locale;
    loadLocalizedStrings();
  }
}
