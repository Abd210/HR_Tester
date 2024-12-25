// lib/widgets/common/sidebar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../providers/auth_provider.dart';

class Sidebar extends StatelessWidget {
  final List<Map<String, dynamic>> adminMenuItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': '/admin/dashboard'},
    {'title': 'Manage Users', 'icon': Icons.people, 'route': '/admin/manage-users'},
    {'title': 'Manage Roles', 'icon': Icons.security, 'route': '/admin/manage-roles'},
    {'title': 'Manage Tests', 'icon': Icons.assignment, 'route': '/admin/manage-tests'},
    {'title': 'Manage Domains', 'icon': Icons.category, 'route': '/admin/manage-domains'},
    {'title': 'Take Test', 'icon': Icons.edit, 'route': '/tests/take'},
    {'title': 'Logout', 'icon': Icons.logout, 'route': '/login'},
  ];

  final List<Map<String, dynamic>> employeeMenuItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': '/admin/dashboard'},
    {'title': 'Take Test', 'icon': Icons.edit, 'route': '/tests/take'},
    {'title': 'My Profile', 'icon': Icons.person, 'route': '/user/profile'},
    {'title': 'Evaluations', 'icon': Icons.assessment, 'route': '/user/evaluations'},
    {'title': 'Salary Suggestions', 'icon': Icons.attach_money, 'route': '/user/salary-suggestions'},
    {'title': 'Logout', 'icon': Icons.logout, 'route': '/login'},
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).currentUser;

    List<Map<String, dynamic>> menuItems = [];

    if (currentUser != null) {
      if (currentUser.role == UserRole.Admin) {
        menuItems = adminMenuItems;
      } else if (currentUser.role == UserRole.Employee) {
        menuItems = employeeMenuItems;
      }
      // Add more roles as needed
    }

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(currentUser?.name ?? 'Guest User'),
            accountEmail: Text(currentUser?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(currentUser?.avatarUrl ?? 'https://i.pravatar.cc/150'),
            ),
          ),
          ...menuItems.map((item) {
            return ListTile(
              leading: Icon(item['icon']),
              title: Text(item['title']),
              onTap: () {
                if (item['route'] == '/login') {
                  // Handle logout
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                } else {
                  Navigator.pushReplacementNamed(context, item['route']);
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
