import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/ocean_background.dart';
import '../widgets/review_tile.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman pembahasan: seluruh soal beserta jawaban dan penjelasannya.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    final questions = quiz.questions;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: OceanBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.narrowMaxWidth,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.sz(2),
                      context.sz(1),
                      context.sz(2),
                      0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: 'Kembali',
                          onPressed: () => Navigator.maybePop(context),
                          iconSize: context.sz(7),
                          color: scheme.onSurface,
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        Expanded(
                          child: Text(
                            'Pembahasan',
                            style: AppText.heading(context, size: 9),
                          ),
                        ),
                        const ThemeToggleButton(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(context.sz(4)),
                      itemCount: questions.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.sz(3)),
                      itemBuilder: (context, index) => ReviewTile(
                        number: index + 1,
                        question: questions[index],
                        selectedIndex: quiz.answerOf(index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}