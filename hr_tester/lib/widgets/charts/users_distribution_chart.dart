// lib/widgets/charts/users_distribution_chart.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UsersDistributionChart extends StatelessWidget {
  final int adminCount;
  final int employeeCount;

  UsersDistributionChart({required this.adminCount, required this.employeeCount});

  @override
  Widget build(BuildContext context) {
    final List<UserRoleData> data = [
      UserRoleData('Admins', adminCount),
      UserRoleData('Employees', employeeCount),
      // Add more roles if necessary
    ];

    return SfCircularChart(
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: <CircularSeries>[
        PieSeries<UserRoleData, String>(
          dataSource: data,
          xValueMapper: (UserRoleData data, _) => data.role,
          yValueMapper: (UserRoleData data, _) => data.count,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          pointColorMapper: (UserRoleData data, _) {
            switch (data.role) {
              case 'Admins':
                return Colors.indigo;
              case 'Employees':
                return Colors.green;
              default:
                return Colors.grey;
            }
          },
        )
      ],
    );
  }
}

class UserRoleData {
  final String role;
  final int count;

  UserRoleData(this.role, this.count);
}
