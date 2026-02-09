import 'package:cielo_estrellado/models/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  final Animation<double> animation;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            
            // Icon with glow effect
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: page.accentColor.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: page.accentColor.withOpacity(0.3),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                page.icon,
                size: 64,
                color: page.accentColor,
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Title
            Text(
              page.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Description
            Text(
              page.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
