// lib/screens/admin/manage_roles_screen.dart
import 'package:flutter/material.dart';

class ManageRolesScreen extends StatelessWidget {
  final List<String> roles = ['Admin', 'Employee', 'Manager'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Roles')),
      body: ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          String role = roles[index];
          return ListTile(
            title: Text(role),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Implement edit role functionality
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add role functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
