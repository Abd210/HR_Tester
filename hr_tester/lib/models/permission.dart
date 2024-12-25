// lib/models/permission.dart

class Permission {
  final String id;
  final String name;
  final String description;

  Permission({
    required this.id,
    required this.name,
    required this.description,
  });

  // Static permissions
  static List<Permission> get allPermissions => [
    Permission(
      id: 'perm1',
      name: 'View Users',
      description: 'Allows viewing user profiles and details.',
    ),
    Permission(
      id: 'perm2',
      name: 'Edit Users',
      description: 'Allows editing user information.',
    ),
    Permission(
      id: 'perm3',
      name: 'Delete Users',
      description: 'Allows deleting user accounts.',
    ),
    // Add more permissions as needed
  ];
}
