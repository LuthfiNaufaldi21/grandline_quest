import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class PirateCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PirateCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return Container(
      padding: padding ?? EdgeInsets.all(context.sz(5)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.sz(4)),
        border: Border.all(
          color: isDark ? AppColors.strawYellow : AppColors.parchmentDark,
          width: context.sz(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: context.sz(4),
            offset: Offset(0, context.sz(1.5)),
          ),
        ],
      ),
      child: child,
    );
  }
}