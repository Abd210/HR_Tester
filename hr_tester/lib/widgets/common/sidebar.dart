// // lib/widgets/common/sidebar.dart
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/auth_provider.dart';
// import '../../models/user.dart'; // Import User and UserRole
//
// class Sidebar extends StatelessWidget {
//   // Define menu items for Admin and Employee roles
//   final List<Map<String, dynamic>> adminMenuItems = [
//     {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': '/admin/dashboard'},
//     {'title': 'Manage Users', 'icon': Icons.people, 'route': '/admin/manage-users'},
//     {'title': 'Manage Roles', 'icon': Icons.security, 'route': '/admin/manage-roles'},
//     {'title': 'Manage Tests', 'icon': Icons.assignment, 'route': '/admin/manage-tests'},
//     {'title': 'Manage Domains', 'icon': Icons.category, 'route': '/admin/manage-domains'},
//     {'title': 'Take Test', 'icon': Icons.edit, 'route': '/tests/take'},
//     {'title': 'Logout', 'icon': Icons.logout, 'route': '/login'},
//   ];
//
//   final List<Map<String, dynamic>> employeeMenuItems = [
//     {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': '/admin/dashboard'},
//     {'title': 'Take Test', 'icon': Icons.edit, 'route': '/tests/take'},
//     {'title': 'My Profile', 'icon': Icons.person, 'route': '/user/profile'},
//     {'title': 'Evaluations', 'icon': Icons.assessment, 'route': '/user/evaluations'},
//     {'title': 'Salary Suggestions', 'icon': Icons.attach_money, 'route': '/user/salary-suggestions'},
//     {'title': 'Logout', 'icon': Icons.logout, 'route': '/login'},
//   ];
//
//   // Optional: Define menu items for other roles if necessary
//   final List<Map<String, dynamic>> defaultMenuItems = [
//     {'title': 'Login', 'icon': Icons.login, 'route': '/login'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final currentUser = Provider.of<AuthProvider>(context).currentUser;
//
//     List<Map<String, dynamic>> menuItems = [];
//
//     if (currentUser != null) {
//       if (currentUser.role == UserRole.Admin) {
//         menuItems = adminMenuItems;
//       } else if (currentUser.role == UserRole.Employee) {
//         menuItems = employeeMenuItems;
//       }
//       // Add more roles here if needed
//     } else {
//       // If no user is logged in, show default menu items
//       menuItems = defaultMenuItems;
//     }
//
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(currentUser?.name ?? 'Guest User'),
//             accountEmail: Text(currentUser?.email ?? 'Please login'),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: NetworkImage(
//                 currentUser?.avatarUrl ??
//                     'https://i.pravatar.cc/150?img=default', // Default avatar image
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.indigo,
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: menuItems.map((item) {
//                 return ListTile(
//                   leading: Icon(item['icon']),
//                   title: Text(item['title']),
//                   onTap: () {
//                     if (item['route'] == '/login') {
//                       // Handle logout
//                       Provider.of<AuthProvider>(context, listen: false).logout();
//                       Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//                     } else {
//                       Navigator.pushReplacementNamed(context, item['route']);
//                     }
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.info),
//             title: Text('About'),
//             onTap: () {
//               // Navigate to About page or show dialog
//               showAboutDialog(
//                 context: context,
//                 applicationName: 'HR Tester',
//                 applicationVersion: '1.0.0',
//                 applicationLegalese: '© 2024 HR Tester. All rights reserved.',
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
