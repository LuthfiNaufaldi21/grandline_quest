import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/pirate_button.dart';
import '../widgets/pirate_card.dart';
import '../widgets/pirate_scaffold.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return PirateScaffold(
      child: PirateCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ahoy, ${quiz.playerName}!',
              textAlign: TextAlign.center,
              style: AppText.heading(context, size: 10),
            ),
            SizedBox(height: context.sz(3)),
            Text(
              'Soal 1 dari ${quiz.total}:',
              style: AppText.body(context, size: 3.6, weight: FontWeight.w600),
            ),
            SizedBox(height: context.sz(1.5)),
            Text(
              quiz.currentQuestion.text,
              style: AppText.body(context, size: 4.2),
            ),
            SizedBox(height: context.sz(5)),
            PirateButton(
              label: 'Kembali ke Beranda',
              icon: Icons.arrow_back_rounded,
              outlined: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}