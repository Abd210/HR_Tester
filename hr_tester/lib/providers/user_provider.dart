// lib/providers/user_provider.dart

import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = List.generate(20, (index) => User.sampleUser((index + 1).toString()));

  List<User> get users => _users;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }

  void updateUser(User updatedUser) {
    int index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
      notifyListeners();
    }
  }
}
