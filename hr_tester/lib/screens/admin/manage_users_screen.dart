// lib/screens/admin/manage_users_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user.dart';
import '../../widgets/common/header.dart';
import '../../widgets/common/sidebar.dart';
import '../../widgets/common/notification_widget.dart';
import 'package:uuid/uuid.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  String _name = '';
  String _email = '';
  UserRole _role = UserRole.Employee;
  String _department = 'Engineering';

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                    onSaved: (value) => _name = value!,
                  ),
                  SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => value == null || !value.contains('@') ? 'Enter valid email' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 16),
                  // Role Dropdown
                  DropdownButtonFormField<UserRole>(
                    value: _role,
                    decoration: InputDecoration(labelText: 'Role'),
                    items: UserRole.values.map((UserRole role) {
                      return DropdownMenuItem<UserRole>(
                        value: role,
                        child: Text(describeEnum(role)),
                      );
                    }).toList(),
                    onChanged: (UserRole? newValue) {
                      setState(() {
                        _role = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Department Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Department'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter department' : null,
                    onSaved: (value) => _department = value!,
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
              child: Text('Add User'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newUser = User(
                    id: _uuid.v4(),
                    name: _name,
                    email: _email,
                    role: _role,
                    avatarUrl: 'https://i.pravatar.cc/150?u=${_uuid.v4()}',
                    joinedDate: DateTime.now(),
                    department: _department,
                    permissions: _role == UserRole.Admin
                        ? ['view_users', 'edit_users', 'delete_users']
                        : ['view_tests'],
                  );
                  Provider.of<UserProvider>(context, listen: false).addUser(newUser);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'User added successfully') as SnackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditUserDialog(BuildContext context, User user) {
    final _editFormKey = GlobalKey<FormState>();
    String _editName = user.name;
    String _editEmail = user.email;
    UserRole _editRole = user.role;
    String _editDepartment = user.department;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: Form(
              key: _editFormKey,
              child: Column(
                children: [
                  // Name Field
                  TextFormField(
                    initialValue: _editName,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                    onSaved: (value) => _editName = value!,
                  ),
                  SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    initialValue: _editEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => value == null || !value.contains('@') ? 'Enter valid email' : null,
                    onSaved: (value) => _editEmail = value!,
                  ),
                  SizedBox(height: 16),
                  // Role Dropdown
                  DropdownButtonFormField<UserRole>(
                    value: _editRole,
                    decoration: InputDecoration(labelText: 'Role'),
                    items: UserRole.values.map((UserRole role) {
                      return DropdownMenuItem<UserRole>(
                        value: role,
                        child: Text(describeEnum(role)),
                      );
                    }).toList(),
                    onChanged: (UserRole? newValue) {
                      setState(() {
                        _editRole = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Department Field
                  TextFormField(
                    initialValue: _editDepartment,
                    decoration: InputDecoration(labelText: 'Department'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter department' : null,
                    onSaved: (value) => _editDepartment = value!,
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
                if (_editFormKey.currentState!.validate()) {
                  _editFormKey.currentState!.save();
                  final updatedUser = User(
                    id: user.id,
                    name: _editName,
                    email: _editEmail,
                    role: _editRole,
                    avatarUrl: user.avatarUrl,
                    joinedDate: user.joinedDate, // Keep original join date
                    department: _editDepartment,
                    permissions: _editRole == UserRole.Admin
                        ? ['view_users', 'edit_users', 'delete_users']
                        : ['view_tests'],
                  );
                  Provider.of<UserProvider>(context, listen: false).updateUser(updatedUser);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'User updated successfully') as SnackBar);
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
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.users;

    return Scaffold(
      appBar: Header(title: 'Manage Users'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Row with Add User Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Users',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddUserDialog(context),
                  icon: Icon(Icons.add),
                  label: Text('Add User'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Users Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Avatar')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Joined Date')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: users.map((user) {
                    return DataRow(cells: [
                      DataCell(CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl))),
                      DataCell(Text(user.name)),
                      DataCell(Text(user.email)),
                      DataCell(Text(describeEnum(user.role))),
                      DataCell(Text(user.department)),
                      DataCell(Text('${user.joinedDate.toLocal()}'.split(' ')[0])),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditUserDialog(context, user),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              userProvider.removeUser(user.id);
                              ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'User removed successfully') as SnackBar);
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
