import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';

/// Satu pilihan jawaban (A/B/C/D) pada halaman kuis.
class OptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final highlight = isDark ? AppColors.strawYellow : AppColors.oceanBlue;
    final radius = BorderRadius.circular(context.sz(3.5));
    final idleFill =
        isDark ? Colors.white.withAlpha(18) : Colors.white.withAlpha(170);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? highlight.withAlpha(45) : idleFill,
        borderRadius: radius,
        border: Border.all(
          color: selected ? highlight : scheme.onSurface.withAlpha(60),
          width: context.sz(selected ? 0.8 : 0.4),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.sz(3.5),
              vertical: context.sz(3),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: context.sz(8.5),
                  height: context.sz(8.5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? highlight : Colors.transparent,
                    border: Border.all(
                      color: highlight,
                      width: context.sz(0.5),
                    ),
                  ),
                  child: Text(
                    letter,
                    style: AppText.heading(
                      context,
                      size: 5.5,
                      color: selected
                          ? (isDark ? AppColors.ink : Colors.white)
                          : highlight,
                    ),
                  ),
                ),
                SizedBox(width: context.sz(3)),
                Expanded(
                  child: Text(
                    text,
                    style: AppText.body(
                      context,
                      size: 3.9,
                      weight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: highlight,
                    size: context.sz(5.5),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}