import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pragament_assgn/providers/theme_provider.dart';
import 'package:pragament_assgn/theme/app_theme.dart';
import 'package:pragament_assgn/theme/gradient_button.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeMode == ThemeMode.dark
              ? AppTheme.darkGradient.gradient
              : null,
        ),
        child: Column(
          children: [
            // Apply gradient to AppBar
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
                backgroundColor: Colors.transparent,
                elevation: 0, // Remove shadow below the AppBar
              ),
            ),
            Expanded(
              child: Center(
                child: GradientButton(
                  text: Text(
                    'View Chart',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => context.go('/chart'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
