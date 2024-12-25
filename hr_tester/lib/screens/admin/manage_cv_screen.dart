// lib/screens/admin/manage_cv_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cv_provider.dart';
import '../../models/cv.dart';
import '../../widgets/common/header.dart';
import '../common/sidebar.dart';
import '../../widgets/common/notification_widget.dart';
import 'package:uuid/uuid.dart';

import '../common/sidebar.dart';

class ManageCvScreen extends StatefulWidget {
  @override
  _ManageCvScreenState createState() => _ManageCvScreenState();
}

class _ManageCvScreenState extends State<ManageCvScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  String _candidateName = '';
  String _email = '';
  String _domain = 'Engineering';
  String _resumeUrl = '';
  bool _hasDrivingLicense = false;
  String _pcSkills = 'Basic';

  void _submitCv(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Ensure mandatory domains are filled
      List<String> mandatoryDetails = [
        'Foreign Languages',
        'Driving License',
        'PC Skills',
      ];

      List<DomainDetail> details = [
        DomainDetail(detailType: 'Foreign Languages', detailValue: 'English, French'),
        DomainDetail(
            detailType: 'Driving License',
            detailValue: _hasDrivingLicense ? 'Yes, B Category' : 'No'),
        DomainDetail(detailType: 'PC Skills', detailValue: _pcSkills),
      ];

      final newCv = Cv(
        id: _uuid.v4(),
        candidateName: _candidateName,
        email: _email,
        domain: _domain,
        resumeUrl: _resumeUrl,
        details: details,
        testResults: [],
      );

      Provider.of<CvProvider>(context, listen: false).addCv(newCv);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'CV submitted successfully') as SnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CvProvider>(context);
    final cvs = cvProvider.cvs;

    return Scaffold(
      appBar: Header(title: 'Manage CVs'),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Row with Add CV Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CVs',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddCvDialog(context),
                  icon: Icon(Icons.add),
                  label: Text('Add CV'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // CVs Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Candidate Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Domain')),
                    DataColumn(label: Text('Resume')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: cvs.map((cv) {
                    return DataRow(cells: [
                      DataCell(Text(cv.candidateName)),
                      DataCell(Text(cv.email)),
                      DataCell(Text(cv.domain)),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            // Implement resume download or view functionality
                          },
                          child: Text('View Resume', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditCvDialog(context, cv),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cvProvider.removeCv(cv.id);
                              ScaffoldMessenger.of(context).showSnackBar(NotificationWidget(message: 'CV removed successfully') as SnackBar);
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

  void _showAddCvDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New CV'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Candidate Name Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Candidate Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter candidate name' : null,
                    onSaved: (value) => _candidateName = value!,
                  ),
                  SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    value == null || !value.contains('@') ? 'Enter a valid email' : null,
                    onSaved: (value) => _email = value!,
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
                  // Resume URL Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Resume URL'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter resume URL' : null,
                    onSaved: (value) => _resumeUrl = value!,
                  ),
                  SizedBox(height: 16),
                  // Driving License Switch
                  SwitchListTile(
                    title: Text('Do you have a driving license?'),
                    value: _hasDrivingLicense,
                    onChanged: (bool value) {
                      setState(() {
                        _hasDrivingLicense = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // PC Skills Dropdown
                  DropdownButtonFormField<String>(
                    value: _pcSkills,
                    decoration: InputDecoration(labelText: 'PC Skills'),
                    items: ['Basic', 'Intermediate', 'Advanced'].map((String skill) {
                      return DropdownMenuItem<String>(
                        value: skill,
                        child: Text(skill),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _pcSkills = newValue!;
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
              child: Text('Submit CV'),
              onPressed: () {
                _submitCv(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCvDialog(BuildContext context, Cv cv) {
    // Implement similar to add CV with pre-filled data
    // This can be expanded based on requirements
  }
}
