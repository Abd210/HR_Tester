// lib/screens/admin/manage_tests_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/test_provider.dart';
import '../../models/test.dart';
import '../../widgets/common/header.dart';
import '../../widgets/common/sidebar.dart';
import '../../widgets/common/notification_widget.dart';
import 'package:uuid/uuid.dart';

class ManageTestsScreen extends StatefulWidget {
  @override
  _ManageTestsScreenState createState() => _ManageTestsScreenState();
}

class _ManageTestsScreenState extends State<ManageTestsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  String _title = '';
  String _domain = 'Engineering';
  bool _isActive = true;

  void _showAddTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Test'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Title Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Test Title'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter test title' : null,
                    onSaved: (value) => _title = value!,
                  ),
                  SizedBox(height: 16),
                  // Domain Dropdown
                  DropdownButtonFormField<String>(
                    value: _domain,
                    decoration: InputDecoration(labelText: 'Domain'),
                    items: ['Engineering', 'Human Resources', 'Marketing', 'Sales'].map((String domain) {
                      return DropdownMenuItem<String>(
                        value: domain,
                        child: Text(domain),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _domain = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Is Active Switch
                  SwitchListTile(
                    title: Text('Is Active'),
                    value: _isActive,
                    onChanged: (bool value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
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
              child: Text('Add Test'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newTest = Test(
                    id: _uuid.v4(),
                    title: _title,
                    domain: _domain,
                    createdDate: DateTime.now(),
                    questions: [], // Initialize with empty questions or add static questions as needed
                    isActive: _isActive,
                  );
                  Provider.of<TestProvider>(context, listen: false).addTest(newTest);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'Test added successfully') as SnackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTestDialog(BuildContext context, Test test) {
    final _editFormKey = GlobalKey<FormState>();
    String _editTitle = test.title;
    String _editDomain = test.domain;
    bool _editIsActive = test.isActive;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Test'),
          content: SingleChildScrollView(
            child: Form(
              key: _editFormKey,
              child: Column(
                children: [
                  // Title Field
                  TextFormField(
                    initialValue: _editTitle,
                    decoration: InputDecoration(labelText: 'Test Title'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter test title' : null,
                    onSaved: (value) => _editTitle = value!,
                  ),
                  SizedBox(height: 16),
                  // Domain Dropdown
                  DropdownButtonFormField<String>(
                    value: _editDomain,
                    decoration: InputDecoration(labelText: 'Domain'),
                    items: ['Engineering', 'Human Resources', 'Marketing', 'Sales'].map((String domain) {
                      return DropdownMenuItem<String>(
                        value: domain,
                        child: Text(domain),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _editDomain = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Is Active Switch
                  SwitchListTile(
                    title: Text('Is Active'),
                    value: _editIsActive,
                    onChanged: (bool value) {
                      setState(() {
                        _editIsActive = value;
                      });
                    },
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
                  final updatedTest = Test(
                    id: test.id,
                    title: _editTitle,
                    domain: _editDomain,
                    createdDate: test.createdDate, // Keep the original creation date
                    questions: test.questions, // Keep existing questions
                    isActive: _editIsActive,
                  );
                  Provider.of<TestProvider>(context, listen: false).updateTest(updatedTest);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'Test updated successfully') as SnackBar);
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
    final testProvider = Provider.of<TestProvider>(context);
    final tests = testProvider.tests;

    return Scaffold(
      appBar: Header(title: 'Manage Tests'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Row with Add Test Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tests',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddTestDialog(context),
                  icon: Icon(Icons.add),
                  label: Text('Add Test'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Tests Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Domain')),
                    DataColumn(label: Text('Created Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: tests.map((test) {
                    return DataRow(cells: [
                      DataCell(Text(test.title)),
                      DataCell(Text(test.domain)),
                      DataCell(Text('${test.createdDate.toLocal()}'.split(' ')[0])),
                      DataCell(
                        Text(
                          test.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: test.isActive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditTestDialog(context, test),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              testProvider.removeTest(test.id);
                              ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'Test removed successfully') as SnackBar);
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
