import 'package:flutter/material.dart';
import 'package:pragament_assgn/models/health_facility.dart';

import 'health_chart_mobile.dart';
import 'health_chart_web.dart';

class HealthChart extends StatelessWidget {
  final List<HealthFacility> facilities;

  const HealthChart({required this.facilities});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Use the mobile layout
          return HealthChartMobile(facilities: facilities);
        } else {
          // Use the web layout
          return HealthChartWeb(facilities: facilities);
        }
      },
    );
  }
}
