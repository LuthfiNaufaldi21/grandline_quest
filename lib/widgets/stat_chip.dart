import 'package:flutter/material.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';

/// Kotak statistik kecil (ikon, angka, label)
class StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const StatChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.sz(3),
        horizontal: context.sz(2),
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(35),
        borderRadius: BorderRadius.circular(context.sz(3)),
        border: Border.all(
          color: color.withAlpha(150),
          width: context.sz(0.4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: context.sz(6)),
          SizedBox(height: context.sz(1)),
          Text(
            '$value',
            style: AppText.heading(context, size: 9, color: color),
          ),
          Text(
            label,
            style: AppText.body(context, size: 3, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}