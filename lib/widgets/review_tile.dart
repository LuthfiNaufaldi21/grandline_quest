import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../data/models/question.dart';
import 'pirate_card.dart';

/// Satu kartu pembahasan: soal, jawaban pemain, jawaban benar, dan penjelasan.
class ReviewTile extends StatelessWidget {
  final int number;
  final Question question;
  final int? selectedIndex;

  const ReviewTile({
    super.key,
    required this.number,
    required this.question,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final okColor = isDark ? Colors.green.shade300 : AppColors.success;
    final badColor = isDark ? Colors.red.shade300 : AppColors.luffyRed;

    final selected = selectedIndex;
    final isCorrect = selected == question.correctIndex;

    final Color statusColor;
    final IconData statusIcon;
    final String statusLabel;
    if (selected == null) {
      statusColor = scheme.onSurface.withAlpha(170);
      statusIcon = Icons.help_rounded;
      statusLabel = 'Kosong';
    } else if (isCorrect) {
      statusColor = okColor;
      statusIcon = Icons.check_circle_rounded;
      statusLabel = 'Benar';
    } else {
      statusColor = badColor;
      statusIcon = Icons.cancel_rounded;
      statusLabel = 'Salah';
    }

    return PirateCard(
      padding: EdgeInsets.all(context.sz(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Soal $number', style: AppText.heading(context, size: 7)),
              const Spacer(),
              Icon(statusIcon, color: statusColor, size: context.sz(5)),
              SizedBox(width: context.sz(1.5)),
              Text(
                statusLabel,
                style: AppText.body(
                  context,
                  size: 3.4,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: context.sz(2)),
          Text(
            question.text,
            style: AppText.body(context, size: 3.9, weight: FontWeight.w600),
          ),
          SizedBox(height: context.sz(3)),
          _AnswerLine(
            label: 'Jawabanmu',
            text: selected == null
                ? 'Tidak dijawab'
                : question.options[selected],
            color: statusColor,
          ),
          if (!isCorrect) ...[
            SizedBox(height: context.sz(1.5)),
            _AnswerLine(
              label: 'Jawaban benar',
              text: question.correctAnswer,
              color: okColor,
            ),
          ],
          SizedBox(height: context.sz(3)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_rounded,
                size: context.sz(5),
                color: scheme.primary,
              ),
              SizedBox(width: context.sz(2)),
              Expanded(
                child: Text(
                  question.explanation,
                  style: AppText.body(
                    context,
                    size: 3.4,
                    color: scheme.onSurface.withAlpha(210),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Satu baris jawaban berlatar warna (hijau/merah/abu).
class _AnswerLine extends StatelessWidget {
  final String label;
  final String text;
  final Color color;

  const _AnswerLine({
    required this.label,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sz(3),
        vertical: context.sz(2),
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(context.sz(2.5)),
        border: Border.all(
          color: color.withAlpha(140),
          width: context.sz(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppText.body(
              context,
              size: 2.9,
              weight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(170),
            ),
          ),
          Text(
            text,
            style: AppText.body(context, size: 3.7, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}