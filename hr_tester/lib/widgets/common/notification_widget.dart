// lib/widgets/common/notification_widget.dart
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String message;

  NotificationWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(message));
  }
}
