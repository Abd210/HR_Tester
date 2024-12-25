// lib/models/user.dart

import 'package:flutter/foundation.dart';

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

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
    required this.joinedDate,
    required this.department,
    required this.permissions,
  });

  // Factory method to generate static users
  factory User.sampleUser(String id) {
    // Attempt to parse the id to an integer; default to 0 if parsing fails
    int numericId = int.tryParse(id) ?? 0;

    return User(
      id: id,
      name: 'User $id',
      email: 'user$id@example.com',
      role: UserRole.values[numericId % UserRole.values.length],
      avatarUrl: 'https://i.pravatar.cc/150?img=${numericId % 70}', // pravatar has images up to 70
      joinedDate: DateTime.now().subtract(Duration(days: numericId * 30)),
      department: ['Engineering', 'Human Resources', 'Marketing', 'Sales'][numericId % 4],
      permissions: ['read', 'write', 'execute'],
    );
  }
}
