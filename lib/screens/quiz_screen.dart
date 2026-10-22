import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/ocean_background.dart';
import '../widgets/option_tile.dart';
import '../widgets/pirate_button.dart';
import '../widgets/pirate_card.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman kuis: satu soal per layar.
/// Layar lebar (tablet/landscape) memakai 2 kolom: soal di kiri, jawaban di kanan.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return Scaffold(
      body: OceanBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = Breakpoints.isWide(constraints);

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: wide
                        ? Breakpoints.wideMaxWidth
                        : Breakpoints.narrowMaxWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.sz(4)),
                    child: Column(
                      children: [
                        _TopBar(quiz: quiz),
                        SizedBox(height: context.sz(3)),
                        Expanded(
                          child: SingleChildScrollView(
                            child: wide
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _QuestionCard(quiz: quiz)),
                                      SizedBox(width: context.sz(4)),
                                      Expanded(child: _Options(quiz: quiz)),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      _QuestionCard(quiz: quiz),
                                      SizedBox(height: context.sz(4)),
                                      _Options(quiz: quiz),
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(height: context.sz(3)),
                        _NavBar(quiz: quiz),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Tombol kembali, nomor soal, progres, dan tombol tema.
class _TopBar extends StatelessWidget {
  final QuizProvider quiz;

  const _TopBar({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final barHeight = context.sz(2.5);

    return Row(
      children: [
        IconButton(
          tooltip: 'Kembali ke beranda',
          onPressed: () => Navigator.maybePop(context),
          iconSize: context.sz(7),
          color: scheme.onSurface,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Soal ${quiz.currentIndex + 1}/${quiz.total}',
                    style: AppText.heading(context, size: 7),
                  ),
                  const Spacer(),
                  Text(
                    '${quiz.answeredCount} terjawab',
                    style: AppText.body(
                      context,
                      size: 3.2,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sz(1.5)),
              ClipRRect(
                borderRadius: BorderRadius.circular(barHeight),
                child: Stack(
                  children: [
                    Container(
                      height: barHeight,
                      color: scheme.onSurface.withAlpha(40),
                    ),
                    AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.centerLeft,
                      widthFactor: (quiz.currentIndex + 1) / quiz.total,
                      child: Container(
                        height: barHeight,
                        color:
                            isDark ? AppColors.strawYellow : AppColors.luffyRed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const ThemeToggleButton(),
      ],
    );
  }
}

/// Kartu berisi teks pertanyaan.
class _QuestionCard extends StatelessWidget {
  final QuizProvider quiz;

  const _QuestionCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return PirateCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.explore_rounded,
            size: context.sz(8),
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: context.sz(3)),
          Expanded(
            child: Text(
              quiz.currentQuestion.text,
              style: AppText.body(context, size: 4.6, weight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// Daftar pilihan jawaban. Jawaban bisa diganti sebelum kuis diselesaikan.
class _Options extends StatelessWidget {
  final QuizProvider quiz;

  const _Options({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final options = quiz.currentQuestion.options;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          OptionTile(
            letter: String.fromCharCode(65 + i), // A, B, C, D
            text: options[i],
            selected: quiz.currentAnswer == i,
            onTap: () => quiz.selectAnswer(i),
          ),
          if (i < options.length - 1) SizedBox(height: context.sz(2.5)),
        ],
      ],
    );
  }
}

/// Tombol Sebelumnya / Selanjutnya (atau Selesai di soal terakhir).
class _NavBar extends StatelessWidget {
  final QuizProvider quiz;

  const _NavBar({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PirateButton(
            label: 'Sebelumnya',
            icon: Icons.arrow_back_rounded,
            outlined: true,
            onPressed: quiz.isFirst ? null : quiz.previous,
          ),
        ),
        SizedBox(width: context.sz(3)),
        Expanded(
          child: PirateButton(
            label: quiz.isLast ? 'Selesai' : 'Selanjutnya',
            icon:
                quiz.isLast ? Icons.flag_rounded : Icons.arrow_forward_rounded,
            onPressed: quiz.isLast ? () => _finish(context) : quiz.next,
          ),
        ),
      ],
    );
  }

  /// Selesaikan kuis. Jika masih ada soal kosong, minta konfirmasi dulu.
  Future<void> _finish(BuildContext context) async {
    if (quiz.unansweredCount > 0) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Belum semua terjawab'),
          content: Text(
            'Masih ada ${quiz.unansweredCount} soal kosong. Tetap selesaikan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Kembali'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Selesaikan'),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) return;
    }

    quiz.finish();
    Navigator.pushReplacementNamed(context, AppRoutes.result);
  }
}