// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/admin/dashboard_screen.dart';
import '../screens/admin/manage_users_screen.dart';
import '../screens/admin/manage_roles_screen.dart';
import '../screens/admin/manage_tests_screen.dart';
import '../screens/admin/manage_domains_screen.dart';
import '../screens/tests/take_test_screen.dart';
import '../screens/tests/test_results_screen.dart';
import '../screens/tests/test_summary_screen.dart';
import '../screens/user/profile_screen.dart';
import '../screens/user/evaluations_screen.dart';
import '../screens/user/salary_suggestions_screen.dart';
import '../screens/common/loading_screen.dart';
import '../screens/common/error_screen.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/login': (context) => LoginScreen(),
    '/register': (context) => RegisterScreen(),
    '/admin/dashboard': (context) => DashboardScreen(),
    '/admin/manage-users': (context) => ManageUsersScreen(),
    '/admin/manage-roles': (context) => ManageRolesScreen(),
    '/admin/manage-tests': (context) => ManageTestsScreen(),
    '/admin/manage-domains': (context) => ManageDomainsScreen(),
    '/tests/take': (context) => TakeTestScreen(),
    '/tests/results': (context) => TestResultsScreen(),
    '/tests/summary': (context) => TestSummaryScreen(),
    '/user/profile': (context) => ProfileScreen(),
    '/user/evaluations': (context) => EvaluationsScreen(),
    '/user/salary-suggestions': (context) => SalarySuggestionsScreen(),
    '/loading': (context) => LoadingScreen(),
    '/error': (context) => ErrorScreen(),
  };
}
