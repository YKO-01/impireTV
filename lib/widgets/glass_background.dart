import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassBackground extends StatelessWidget {
  final Widget child;

  const GlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.backgroundBlack,
            AppTheme.backgroundBlackLight,
          ],
        ),
      ),
      child: child,
    );
  }
}

