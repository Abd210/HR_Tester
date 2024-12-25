// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';
import '../common/loading_screen.dart';
import '../common/error_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isSubmitting = false;

  void _submitLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSubmitting = true;
      });

      await Provider.of<AuthProvider>(context, listen: false).login(_email, _password);

      setState(() {
        _isSubmitting = false;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.currentUser != null) {
        // Navigate to Admin or Employee Dashboard based on role
        if (authProvider.currentUser!.role == UserRole.Admin) {
          Navigator.pushReplacementNamed(context, '/admin/dashboard');
        } else if (authProvider.currentUser!.role == UserRole.Employee) {
          Navigator.pushReplacementNamed(context, '/admin/dashboard'); // Adjust route if Employee has a different dashboard
        }
      } else if (authProvider.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.error!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (_isSubmitting || authProvider.isLoading) {
      return LoadingScreen(message: 'Logging in...');
    }

    if (authProvider.error != null) {
      return ErrorScreen(errorMessage: authProvider.error!);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    value == null || !value.contains('@') ? 'Enter a valid email' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 16),
                  // Password Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                    value == null || value.length < 6 ? 'Enter at least 6 characters' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  SizedBox(height: 24),
                  // Login Button
                  ElevatedButton(
                    onPressed: () => _submitLogin(context),
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Register Link
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Don\'t have an account? Register here'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
