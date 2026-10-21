import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';

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
    _nameController.text = context.read<QuizProvider>().playerName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    final name = _nameController.text.trim();

    if (name.length < AppConfig.minNameLength) {
      setState(() {
        _errorText = 'Nama minimal ${AppConfig.minNameLength} huruf, Nakama!';
      });
      return;
    }

    setState(() => _errorText = null);
    final quiz = context.read<QuizProvider>()..startQuiz(name);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Ahoy, ${quiz.playerName}! ${quiz.total} soal siap. '
            'Halaman kuis menyusul di langkah berikutnya.',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = context.watch<ThemeProvider>().isDark;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark ? AppColors.darkGradient : AppColors.lightGradient,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: EdgeInsets.all(context.sz(5)),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: Breakpoints.narrowMaxWidth,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildHeader(context, scheme),
                                SizedBox(height: context.sz(6)),
                                _buildFormCard(context, scheme, isDark),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: context.sz(1),
                right: context.sz(2),
                child: IconButton(
                  tooltip: isDark ? 'Mode siang' : 'Mode malam',
                  onPressed: () => context.read<ThemeProvider>().toggle(),
                  iconSize: context.sz(7),
                  color: scheme.onSurface,
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme scheme) {
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

  Widget _buildFormCard(BuildContext context, ColorScheme scheme, bool isDark) {
    final errorColor = isDark ? Colors.red.shade200 : AppColors.luffyRed;

    return Container(
      padding: EdgeInsets.all(context.sz(5)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.sz(4)),
        border: Border.all(
          color: isDark ? AppColors.strawYellow : AppColors.parchmentDark,
          width: context.sz(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: context.sz(4),
            offset: Offset(0, context.sz(1.5)),
          ),
        ],
      ),
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
          FilledButton.icon(
            onPressed: _startQuiz,
            icon: Icon(Icons.directions_boat_rounded, size: context.sz(6)),
            label: const Text('Mulai Berlayar'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.strawYellow,
              foregroundColor: AppColors.ink,
              padding: EdgeInsets.symmetric(vertical: context.sz(3.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.sz(3)),
              ),
              textStyle: AppText.body(
                context,
                size: 4.4,
                weight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
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