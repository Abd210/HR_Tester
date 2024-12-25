// lib/screens/user/profile_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';
import '../../widgets/common/sidebar.dart';
import '../../widgets/common/header.dart';

class ProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  void _showEditProfileDialog(BuildContext context, User user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _departmentController.text = user.department;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                  ),
                  SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => value == null || !value.contains('@') ? 'Enter valid email' : null,
                  ),
                  SizedBox(height: 16),
                  // Department Field
                  TextFormField(
                    controller: _departmentController,
                    decoration: InputDecoration(labelText: 'Department'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter department' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Update user profile logic here
                  // For static data, simply pop the dialog
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = Provider.of<AuthProvider>(context).currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: Header(title: 'Profile'),
        drawer: Sidebar(),
        body: Center(child: Text('No user logged in.')),
      );
    }

    return Scaffold(
      appBar: Header(title: '${currentUser.name}\'s Profile'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // User Avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(currentUser.avatarUrl),
            ),
            SizedBox(height: 24),

            // User Details
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text(currentUser.name),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(currentUser.email),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Role'),
              subtitle: Text(describeEnum(currentUser.role)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.apartment),
              title: Text('Department'),
              subtitle: Text(currentUser.department),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Joined Date'),
              subtitle: Text('${currentUser.joinedDate.toLocal()}'.split(' ')[0]),
            ),
            Divider(),

            SizedBox(height: 32),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () => _showEditProfileDialog(context, currentUser),
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
