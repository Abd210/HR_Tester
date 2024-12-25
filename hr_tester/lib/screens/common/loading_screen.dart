// lib/widgets/common/loading_screen.dart

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String message;

  LoadingScreen({this.message = 'Loading, please wait...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(strokeWidth: 6),
            SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
