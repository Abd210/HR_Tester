// lib/screens/admin/manage_domains_screen.dart
import 'package:flutter/material.dart';

class ManageDomainsScreen extends StatelessWidget {
  final List<String> domains = ['Engineering', 'Human Resources', 'Marketing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Domains')),
      body: ListView.builder(
        itemCount: domains.length,
        itemBuilder: (context, index) {
          String domain = domains[index];
          return ListTile(
            title: Text(domain),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Implement edit domain functionality
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add domain functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
