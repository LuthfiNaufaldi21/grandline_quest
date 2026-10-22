import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_text.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';
import '../data/models/pirate_rank.dart';
import '../providers/quiz_provider.dart';
import '../widgets/pirate_button.dart';
import '../widgets/pirate_card.dart';
import '../widgets/pirate_scaffold.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    final scheme = Theme.of(context).colorScheme;
    final rank = PirateRank.fromPercentage(quiz.percentage);

    return PirateScaffold(
      child: PirateCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hasil Pelayaran',
              textAlign: TextAlign.center,
              style: AppText.body(
                context,
                size: 3.6,
                weight: FontWeight.w600,
                color: scheme.onSurface.withAlpha(170),
              ),
            ),
            SizedBox(height: context.sz(1)),
            Text(
              quiz.playerName,
              textAlign: TextAlign.center,
              style: AppText.heading(context, size: 11),
            ),
            SizedBox(height: context.sz(3)),
            Text(
              '${quiz.score}/${quiz.total}',
              textAlign: TextAlign.center,
              style: AppText.heading(context, size: 22, color: scheme.primary),
            ),
            Text(
              '${quiz.percentage}% benar',
              textAlign: TextAlign.center,
              style: AppText.body(context, size: 3.8, weight: FontWeight.w600),
            ),
            SizedBox(height: context.sz(4)),
            Text(
              rank.title,
              textAlign: TextAlign.center,
              style: AppText.heading(context, size: 9),
            ),
            SizedBox(height: context.sz(1)),
            Text(
              rank.message,
              textAlign: TextAlign.center,
              style: AppText.body(context, size: 3.6),
            ),
            SizedBox(height: context.sz(3)),
            Text(
              'Bounty: ${formatNumber(quiz.bounty)} Berry',
              textAlign: TextAlign.center,
              style: AppText.body(context, size: 4, weight: FontWeight.w700),
            ),
            SizedBox(height: context.sz(5)),
            PirateButton(
              label: 'Main Lagi',
              icon: Icons.replay_rounded,
              onPressed: () {
                quiz.restart();
                Navigator.pushReplacementNamed(context, AppRoutes.quiz);
              },
            ),
            SizedBox(height: context.sz(2.5)),
            PirateButton(
              label: 'Kembali ke Beranda',
              icon: Icons.home_rounded,
              outlined: true,
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
            ),
          ],
        ),
      ),
    );
  }
}