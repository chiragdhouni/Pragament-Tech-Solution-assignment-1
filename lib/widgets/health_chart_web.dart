import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pragament_assgn/providers/theme_provider.dart';
import 'package:pragament_assgn/theme/app_theme.dart';
import '../models/health_facility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HealthChartWeb extends ConsumerWidget {
  final List<HealthFacility> facilities;

  HealthChartWeb({required this.facilities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double barWidth = 40;
    double padding = 20;
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: padding),
        decoration: themeMode == ThemeMode.dark ? AppTheme.darkGradient : null,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: facilities.length * 120 + 200,
            height: screenHeight - 40,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: facilities
                        .map((facility) => facility.valueReported)
                        .reduce((a, b) => a > b ? a : b) *
                    1.1,
                barGroups: [
                  BarChartGroupData(
                    x: -1,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  ...facilities.map((facility) {
                    return BarChartGroupData(
                      x: facilities.indexOf(facility),
                      barRods: [
                        BarChartRodData(
                          toY: facility.valueReported.toDouble(),
                          width: barWidth,
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.deepPurpleAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  BarChartGroupData(
                    x: facilities.length,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                              color: themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 80,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= facilities.length) {
                          return const SizedBox.shrink();
                        }
                        final facilityName = facilities[index].facility;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            facilityName.replaceAll(' ', '\n'),
                            style: TextStyle(
                                fontSize: 12,
                                color: themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50, // Adjust as needed
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                              color: themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50, // Adjust as needed
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                              color: themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          color: themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
