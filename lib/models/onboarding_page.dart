import 'dart:ui';

import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  static List<OnboardingPage> getPages(AppLocalizations l10n) {
    return [
      OnboardingPage(
        title: l10n.onboardingWelcomeTitle,
        description: l10n.onboardingWelcomeDesc,
        icon: Icons.auto_awesome,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: l10n.onboardingStarsTitle,
        description: l10n.onboardingStarsDesc,
        icon: Icons.timer_outlined,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: l10n.onboardingConstellationsTitle,
        description: l10n.onboardingConstellationsDesc,
        icon: Icons.star,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: l10n.onboardingGoalsTitle,
        description: l10n.onboardingGoalsDesc,
        icon: Icons.task_alt,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: l10n.onboardingDistractionsTitle,
        description: l10n.onboardingDistractionsDesc,
        icon: Icons.block,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: l10n.onboardingProgressTitle,
        description: l10n.onboardingProgressDesc,
        icon: Icons.query_stats,
        accentColor: const Color(0xFFFFD1A4),
      ),
      OnboardingPage(
        title: 'Misiones y Niveles',
        description: 'Sistema de misiones y niveles para mantener tu foco',
        icon: Icons.assignment,
        accentColor: const Color(0xFFFFD1A4),
      ),
    ];
  }
}
