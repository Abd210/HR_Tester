// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/test_provider.dart';
import 'providers/cv_provider.dart';
import 'providers/localization_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<TestProvider>(create: (_) => TestProvider()),
        ChangeNotifierProvider<CvProvider>(create: (_) => CvProvider()),
        ChangeNotifierProvider<LocalizationProvider>(create: (_) => LocalizationProvider()),
        // Add other providers here
      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, _) {
          return MaterialApp(
            title: 'HR Tester',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            locale: localizationProvider.currentLocale,
            supportedLocales: [
              const Locale('en', ''),
              const Locale('fr', ''),
              const Locale('es', ''),
              // Add other locales here
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // Add other localization delegates here
            ],
            routes: AppRoutes.routes,
            initialRoute: '/login',
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
