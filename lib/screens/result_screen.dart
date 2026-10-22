import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../data/models/pirate_rank.dart';
import '../providers/quiz_provider.dart';
import '../widgets/pirate_button.dart';
import '../widgets/pirate_card.dart';
import '../widgets/pirate_scaffold.dart';
import '../widgets/stat_chip.dart';
import '../widgets/wanted_poster.dart';

/// Halaman hasil: poster WANTED, gelar bajak laut, dan ringkasan skor.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    final wide =
        Breakpoints.isWide(BoxConstraints.tight(MediaQuery.sizeOf(context)));

    final poster = WantedPoster(name: quiz.playerName, bounty: quiz.bounty);
    final summary = _Summary(quiz: quiz);

    return PirateScaffold(
      maxWidth: wide ? Breakpoints.wideMaxWidth : Breakpoints.narrowMaxWidth,
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: poster),
                SizedBox(width: context.sz(5)),
                Expanded(child: summary),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                poster,
                SizedBox(height: context.sz(5)),
                summary,
              ],
            ),
    );
  }
}

/// Kartu ringkasan: gelar, skor, statistik, dan tombol aksi.
class _Summary extends StatelessWidget {
  final QuizProvider quiz;

  const _Summary({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final rank = PirateRank.fromPercentage(quiz.percentage);

    return PirateCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'GELAR KAMU',
            textAlign: TextAlign.center,
            style: AppText.body(
              context,
              size: 3,
              weight: FontWeight.w600,
              color: scheme.onSurface.withAlpha(170),
            ).copyWith(letterSpacing: context.sz(0.5)),
          ),
          SizedBox(height: context.sz(1)),
          Text(
            rank.title,
            textAlign: TextAlign.center,
            style: AppText.heading(context, size: 11, color: scheme.primary),
          ),
          SizedBox(height: context.sz(1.5)),
          Text(
            rank.message,
            textAlign: TextAlign.center,
            style: AppText.body(context, size: 3.6),
          ),
          SizedBox(height: context.sz(4)),
          Text(
            '${quiz.score}/${quiz.total}',
            textAlign: TextAlign.center,
            style: AppText.heading(context, size: 16),
          ),
          Text(
            '${quiz.percentage}% jawaban benar',
            textAlign: TextAlign.center,
            style: AppText.body(context, size: 3.4, weight: FontWeight.w600),
          ),
          SizedBox(height: context.sz(4)),
          Row(
            children: [
              Expanded(
                child: StatChip(
                  icon: Icons.check_circle_rounded,
                  label: 'Benar',
                  value: quiz.score,
                  color: isDark ? Colors.green.shade300 : AppColors.success,
                ),
              ),
              SizedBox(width: context.sz(2.5)),
              Expanded(
                child: StatChip(
                  icon: Icons.cancel_rounded,
                  label: 'Salah',
                  value: quiz.wrongCount,
                  color: isDark ? Colors.red.shade300 : AppColors.luffyRed,
                ),
              ),
              SizedBox(width: context.sz(2.5)),
              Expanded(
                child: StatChip(
                  icon: Icons.help_rounded,
                  label: 'Kosong',
                  value: quiz.unansweredCount,
                  color: scheme.onSurface.withAlpha(180),
                ),
              ),
            ],
          ),
          SizedBox(height: context.sz(5)),
          PirateButton(
            label: 'Lihat Pembahasan',
            icon: Icons.menu_book_rounded,
            onPressed: () => Navigator.pushNamed(context, AppRoutes.review),
          ),
          SizedBox(height: context.sz(2.5)),
          Row(
            children: [
              Expanded(
                child: PirateButton(
                  label: 'Main Lagi',
                  icon: Icons.replay_rounded,
                  outlined: true,
                  onPressed: () {
                    quiz.restart();
                    Navigator.pushReplacementNamed(context, AppRoutes.quiz);
                  },
                ),
              ),
              SizedBox(width: context.sz(2.5)),
              Expanded(
                child: PirateButton(
                  label: 'Beranda',
                  icon: Icons.home_rounded,
                  outlined: true,
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}