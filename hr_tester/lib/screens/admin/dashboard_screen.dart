// lib/screens/admin/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/test_provider.dart';
import '../common/sidebar.dart';
import '../../models/user.dart';
import '../../models/test.dart';
import '../../widgets/charts/users_distribution_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final testProvider = Provider.of<TestProvider>(context);

    List<User> admins = userProvider.users.where((user) => user.role == UserRole.Admin).toList();
    List<User> employees = userProvider.users.where((user) => user.role == UserRole.Employee).toList();
    List<TestModel> activeTests = testProvider.tests.where((test) => test.isActive).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      drawer: Sidebar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome Message
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome, Admin!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),

            // Statistics Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Total Users', userProvider.users.length.toString(), Icons.people),
                _buildStatCard('Admins', admins.length.toString(), Icons.admin_panel_settings),
                _buildStatCard('Employees', employees.length.toString(), Icons.person),
                _buildStatCard('Active Tests', activeTests.length.toString(), Icons.assignment),
              ],
            ),
            SizedBox(height: 24),

            // Users Distribution Pie Chart using Syncfusion
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Users Distribution', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    UsersDistributionChart(adminCount: admins.length, employeeCount: employees.length),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Active Tests List
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Active Tests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: activeTests.length,
              itemBuilder: (context, index) {
                final TestModel test = activeTests[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: Colors.blue),
                    title: Text(test.title),
                    subtitle: Text('Domain: ${test.domainId}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to test details or management screen
                      Navigator.pushNamed(context, '/admin/manage-tests');
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 24),

            // Recent User Activities (Static Data)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent User Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Static recent activities
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('User ${index + 1} completed a test'),
                  subtitle: Text('Just now'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.indigo),
              SizedBox(height: 16),
              Text(
                count,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
