import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';
import 'ocean_background.dart';
import 'theme_toggle_button.dart';

class PirateScaffold extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PirateScaffold({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.narrowMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OceanBackground(
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
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: child,
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
                child: const ThemeToggleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}