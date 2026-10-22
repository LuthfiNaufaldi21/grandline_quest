import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/utils/responsive.dart';
import '../providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return IconButton(
      tooltip: isDark ? 'Mode siang' : 'Mode malam',
      onPressed: () => context.read<ThemeProvider>().toggle(),
      iconSize: context.sz(7),
      color: Theme.of(context).colorScheme.onSurface,
      icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
    );
  }
}