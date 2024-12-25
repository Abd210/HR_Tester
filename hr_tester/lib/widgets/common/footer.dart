// lib/widgets/common/footer.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16.0),
      child: Center(child: Text('© 2024 HR Tester. All rights reserved.')),
    );
  }
}
