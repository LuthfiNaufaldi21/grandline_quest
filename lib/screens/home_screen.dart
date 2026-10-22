import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/pirate_button.dart';
import '../widgets/pirate_card.dart';
import '../widgets/pirate_scaffold.dart';

/// Halaman awal: pemain memasukkan nama sebelum memulai kuis.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Jika pemain kembali ke halaman ini, nama sebelumnya terisi otomatis.
    _nameController.text = context.read<QuizProvider>().playerName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Mulai kuis baru (soal diacak ulang), lalu pindah ke halaman kuis.
  void _startQuiz() {
    final name = _nameController.text.trim();

    if (name.length < AppConfig.minNameLength) {
      setState(() {
        _errorText = 'Nama minimal ${AppConfig.minNameLength} huruf, Nakama!';
      });
      return;
    }

    setState(() => _errorText = null);
    context.read<QuizProvider>().startQuiz(name);
    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  /// Lanjutkan kuis yang sedang berjalan tanpa mengubah progres.
  void _continueQuiz() => Navigator.pushNamed(context, AppRoutes.quiz);

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return PirateScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Header(),
          SizedBox(height: context.sz(6)),
          _buildForm(context, quiz),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, QuizProvider quiz) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final errorColor = isDark ? Colors.red.shade200 : AppColors.luffyRed;

    return PirateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Siapa namamu, calon Raja Bajak Laut?',
            style: AppText.body(context, size: 4.2, weight: FontWeight.w600),
          ),
          SizedBox(height: context.sz(3)),
          TextField(
            controller: _nameController,
            maxLength: AppConfig.maxNameLength,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (_) {
              if (_errorText != null) setState(() => _errorText = null);
            },
            onSubmitted: (_) => _startQuiz(),
            style: AppText.body(context, size: 4.2, weight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: 'Contoh: Monkey D. Luffy',
              hintStyle: AppText.body(
                context,
                size: 3.8,
                color: scheme.onSurface.withAlpha(110),
              ),
              errorText: _errorText,
              errorStyle: AppText.body(
                context,
                size: 3.2,
                weight: FontWeight.w600,
                color: errorColor,
              ),
              counterText: '',
              filled: true,
              fillColor: isDark
                  ? Colors.white.withAlpha(20)
                  : Colors.white.withAlpha(160),
              prefixIcon: Icon(
                Icons.person_rounded,
                size: context.sz(6),
                color: scheme.onSurface,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.sz(4),
                vertical: context.sz(3.6),
              ),
              border: _border(context, Colors.transparent),
              enabledBorder: _border(context, Colors.transparent),
              focusedBorder: _border(context, scheme.primary),
              errorBorder: _border(context, errorColor),
              focusedErrorBorder: _border(context, errorColor),
            ),
          ),
          SizedBox(height: context.sz(4)),
          if (quiz.isInProgress) ...[
            PirateButton(
              label: 'Lanjutkan (${quiz.answeredCount}/${quiz.total} terjawab)',
              icon: Icons.play_arrow_rounded,
              onPressed: _continueQuiz,
            ),
            SizedBox(height: context.sz(2.5)),
            PirateButton(
              label: 'Mulai Baru',
              icon: Icons.refresh_rounded,
              outlined: true,
              onPressed: _startQuiz,
            ),
          ] else
            PirateButton(
              label: 'Mulai Berlayar',
              icon: Icons.directions_boat_rounded,
              onPressed: _startQuiz,
            ),
          SizedBox(height: context.sz(2.5)),
          Text(
            '${AppConfig.questionsPerRound} soal acak seputar One Piece',
            textAlign: TextAlign.center,
            style: AppText.body(
              context,
              size: 3.2,
              color: scheme.onSurface.withAlpha(170),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.sz(3)),
      borderSide: BorderSide(color: color, width: context.sz(0.6)),
    );
  }
}

/// Logo, judul, dan tagline aplikasi.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Image.asset(
          AppAssets.logo,
          width: context.sz(30),
          height: context.sz(30),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.directions_boat_rounded,
            size: context.sz(26),
            color: scheme.primary,
          ),
        ),
        SizedBox(height: context.sz(2)),
        Text(
          AppConfig.appName,
          textAlign: TextAlign.center,
          style: AppText.heading(context, size: 13).copyWith(
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: context.sz(1.5),
                offset: Offset(0, context.sz(0.5)),
              ),
            ],
          ),
        ),
        SizedBox(height: context.sz(1.5)),
        Text(
          AppConfig.tagline.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppText.body(context, size: 3.4, weight: FontWeight.w600)
              .copyWith(letterSpacing: context.sz(0.6)),
        ),
      ],
    );
  }
}