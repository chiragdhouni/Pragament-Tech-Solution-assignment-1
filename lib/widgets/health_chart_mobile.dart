import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pragament_assgn/providers/theme_provider.dart';
import 'package:pragament_assgn/theme/app_theme.dart';
import '../models/health_facility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HealthChartMobile extends ConsumerWidget {
  final List<HealthFacility> facilities;

  HealthChartMobile({required this.facilities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeMode = ref.watch(themeNotifierProvider);

    final textColor = themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: themeMode == ThemeMode.dark ? AppTheme.darkGradient : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double barWidth =
                  (constraints.maxWidth - 80) / (facilities.length * 1.2);
              double maxYValue = facilities
                      .map((facility) => facility.valueReported)
                      .reduce((a, b) => a > b ? a : b) *
                  1.1;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: (facilities.length + 2) * (barWidth + 60),
                    height: constraints.maxHeight * 0.8,
                    child: Stack(
                      children: [
                        BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: maxYValue,
                            barGroups: facilities.map(
                              (facility) {
                                return BarChartGroupData(
                                  x: facilities.indexOf(facility),
                                  barRods: [
                                    BarChartRodData(
                                      toY: facility.valueReported.toDouble(),
                                      width: barWidth,
                                      borderRadius: BorderRadius.circular(4),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.purple,
                                          Colors.deepPurpleAccent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 90,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 ||
                                        index >= facilities.length) {
                                      return const SizedBox.shrink();
                                    }
                                    final facilityName =
                                        facilities[index].facility;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        facilityName.replaceAll(' ', '\n'),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                            borderData: FlBorderData(show: false),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    rod.toY.toString(),
                                    TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
