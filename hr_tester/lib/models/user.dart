// lib/models/user.dart

import 'package:flutter/foundation.dart';

import 'cv.dart';

enum UserRole { Admin, Employee, Manager }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String avatarUrl;
  final DateTime joinedDate;
  final String department;
  final List<String> permissions;
  final List<Cv> cvs;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
    required this.joinedDate,
    required this.department,
    required this.permissions,
    required this.cvs,
  });

  // Factory method to generate static users
  factory User.sampleUser(String id) {
    int numericId = int.tryParse(id) ?? 0;

    return User(
      id: id,
      name: 'User $id',
      email: 'user$id@example.com',
      role: UserRole.values[numericId % UserRole.values.length],
      avatarUrl: 'https://i.pravatar.cc/150?img=${numericId % 70}',
      joinedDate: DateTime.now().subtract(Duration(days: numericId * 30)),
      department: ['Engineering', 'Human Resources', 'Marketing', 'Sales'][numericId % 4],
      permissions: _definePermissions(UserRole.values[numericId % UserRole.values.length]),
      cvs: [], // Initialize with empty CVs
    );
  }

  static List<String> _definePermissions(UserRole role) {
    switch (role) {
      case UserRole.Admin:
        return ['view_users', 'edit_users', 'delete_users', 'manage_tests', 'manage_domains'];
      case UserRole.Employee:
        return ['view_tests', 'take_tests', 'view_profile'];
      case UserRole.Manager:
        return ['view_users', 'edit_users', 'view_evaluations'];
      default:
        return [];
    }
  }
}
