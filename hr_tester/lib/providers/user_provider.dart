// lib/providers/user_provider.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:uuid/uuid.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = List.generate(10, (index) => User.sampleUser((index + 1).toString()));
  final Uuid _uuid = Uuid();

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
