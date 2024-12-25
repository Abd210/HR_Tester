// lib/screens/admin/manage_tests_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/test_provider.dart';
import '../../models/test.dart';
import '../common/sidebar.dart';
import '../../widgets/common/header.dart';
import 'package:uuid/uuid.dart';

class ManageTestsScreen extends StatefulWidget {
  @override
  _ManageTestsScreenState createState() => _ManageTestsScreenState();
}

class _ManageTestsScreenState extends State<ManageTestsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  String _title = '';
  String _domainId = '1'; // Assuming domain IDs are '1', '2', etc.
  bool _isActive = true;
  DateTime _scheduledDate = DateTime.now();

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
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter test title' : null,
                    onSaved: (value) => _title = value!,
                  ),
                  SizedBox(height: 16),
                  // Domain Dropdown
                  DropdownButtonFormField<String>(
                    value: _domainId,
                    decoration: InputDecoration(labelText: 'Domain'),
                    items: [
                      {'id': '1', 'name': 'Engineering'},
                      {'id': '2', 'name': 'Human Resources'},
                      {'id': '3', 'name': 'Marketing'},
                      {'id': '4', 'name': 'Sales'},
                      // Add more domains as needed
                    ].map((domain) {
                      return DropdownMenuItem<String>(
                        value: domain['id'],
                        child: Text(domain['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _domainId = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Scheduled Date Picker
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Scheduled Date: ${_scheduledDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TextButton(
                        child: Text('Select Date'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _scheduledDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (pickedDate != null && pickedDate != _scheduledDate) {
                            setState(() {
                              _scheduledDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
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
                  final newTest = TestModel(
                    id: _uuid.v4(),
                    title: _title,
                    domainId: _domainId, // Use domainId instead of domain
                    createdDate: _scheduledDate, // Use scheduledDate as createdDate
                    questions: [], // Initialize with empty questions or add static questions as needed
                    isActive: _isActive,
                  );
                  Provider.of<TestProvider>(context, listen: false).addTest(newTest);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Test added successfully')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTestDialog(BuildContext context, TestModel test) {
    final _editFormKey = GlobalKey<FormState>();
    String _editTitle = test.title;
    String _editDomainId = test.domainId;
    bool _editIsActive = test.isActive;
    DateTime _editScheduledDate = test.createdDate;

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
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter test title' : null,
                    onSaved: (value) => _editTitle = value!,
                  ),
                  SizedBox(height: 16),
                  // Domain Dropdown
                  DropdownButtonFormField<String>(
                    value: _editDomainId,
                    decoration: InputDecoration(labelText: 'Domain'),
                    items: [
                      {'id': '1', 'name': 'Engineering'},
                      {'id': '2', 'name': 'Human Resources'},
                      {'id': '3', 'name': 'Marketing'},
                      {'id': '4', 'name': 'Sales'},
                      // Add more domains as needed
                    ].map((domain) {
                      return DropdownMenuItem<String>(
                        value: domain['id'],
                        child: Text(domain['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _editDomainId = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Scheduled Date Picker
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Scheduled Date: ${_editScheduledDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TextButton(
                        child: Text('Select Date'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _editScheduledDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (pickedDate != null && pickedDate != _editScheduledDate) {
                            setState(() {
                              _editScheduledDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
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
                  final updatedTest = TestModel(
                    id: test.id,
                    title: _editTitle,
                    domainId: _editDomainId,
                    createdDate: _editScheduledDate,
                    questions: test.questions, // Keep existing questions
                    isActive: _editIsActive,
                  );
                  Provider.of<TestProvider>(context, listen: false).updateTest(updatedTest);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Test updated successfully')),
                  );
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
                    DataColumn(label: Text('Scheduled Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: tests.map((test) {
                    return DataRow(cells: [
                      DataCell(Text(test.title)),
                      DataCell(Text(_getDomainName(test.domainId))), // Map domainId to domain name
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Test removed successfully')),
                              );
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

  String _getDomainName(String domainId) {
    // Map domainId to domain name
    switch (domainId) {
      case '1':
        return 'Engineering';
      case '2':
        return 'Human Resources';
      case '3':
        return 'Marketing';
      case '4':
        return 'Sales';
      default:
        return 'Unknown';
    }
  }
}
