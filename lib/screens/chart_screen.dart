import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pragament_assgn/providers/theme_provider.dart';
import 'package:pragament_assgn/theme/app_theme.dart';
import '../providers/data_provider.dart';
import '../widgets/health_chart.dart';

class ChartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final healthFacilitiesAsync = ref.watch(healthFacilitiesProvider);
    log("healthFacilitiesAsync: ${healthFacilitiesAsync.toString()}");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeMode == ThemeMode.dark
              ? AppTheme.darkGradient.gradient
              : null,
        ),
        child: Column(
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: themeMode == ThemeMode.dark
                        ? AppTheme.darkGradient.gradient
                        : null,
                  ),
                ),
                title: Text('Health Facility Analysis',
                    style: TextStyle(
                        color: themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20)),
                actions: [
                  IconButton(
                    icon: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    onPressed: () =>
                        ref.read(themeNotifierProvider.notifier).toggleTheme(),
                  ),
                ],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black),
                  onPressed: () {
                    context.go('/');
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Expanded(
              child: healthFacilitiesAsync.when(
                data: (facilities) => HealthChart(facilities: facilities),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
