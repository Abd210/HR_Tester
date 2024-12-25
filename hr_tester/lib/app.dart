// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/test_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<TestProvider>(create: (_) => TestProvider()),
        // Add other providers here
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'HR Tester',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            routes: AppRoutes.routes,
            initialRoute: authProvider.currentUser == null ? '/login' : '/admin/dashboard',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              // Add localization delegates here
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('fr', ''),
              const Locale('es', ''),
              // Add other locales here
            ],
          );
        },
      ),
    );
  }
}
