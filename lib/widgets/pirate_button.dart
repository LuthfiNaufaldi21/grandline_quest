import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';

/// Tombol utama aplikasi ([outlined] = true untuk tombol sekunder).
/// Jika [onPressed] bernilai null, tombol tampil nonaktif.
class PirateButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool outlined;

  const PirateButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null;
    final baseColor = outlined ? scheme.onSurface : AppColors.ink;
    final color = enabled ? baseColor : baseColor.withAlpha(110);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.sz(3)),
    );
    final padding = EdgeInsets.symmetric(
      vertical: context.sz(3.2),
      horizontal: context.sz(3),
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: context.sz(5.5), color: color),
          SizedBox(width: context.sz(2)),
        ],
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppText.body(
              context,
              size: 4,
              weight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          padding: padding,
          shape: shape,
          side: BorderSide(
            color: baseColor.withAlpha(enabled ? 140 : 60),
            width: context.sz(0.5),
          ),
        ),
        child: content,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.strawYellow,
        foregroundColor: AppColors.ink,
        disabledBackgroundColor: AppColors.strawYellow.withAlpha(90),
        padding: padding,
        shape: shape,
      ),
      child: content,
    );
  }
}