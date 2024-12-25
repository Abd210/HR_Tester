// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Simulate a login with static data
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simple authentication logic for demonstration
    if (email == 'admin@example.com' && password == 'password') {
      _currentUser = User(
        id: '1',
        name: 'Admin User',
        email: email,
        role: UserRole.Admin,
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        joinedDate: DateTime(2020, 1, 1),
        department: 'Administration',
        permissions: ['view_users', 'edit_users', 'delete_users'],
      );
      _error = null;
    } else if (email == 'employee@example.com' && password == 'password') {
      _currentUser = User(
        id: '2',
        name: 'Employee User',
        email: email,
        role: UserRole.Employee,
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        joinedDate: DateTime(2021, 6, 15),
        department: 'Engineering',
        permissions: ['view_tests'],
      );
      _error = null;
    } else {
      _error = 'Invalid email or password';
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
