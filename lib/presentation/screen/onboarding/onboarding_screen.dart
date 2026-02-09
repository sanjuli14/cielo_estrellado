import 'package:cielo_estrellado/features/sky/sky_painter.dart';
import 'package:flutter/material.dart';
import 'package:cielo_estrellado/core/storage/onboarding_storage.dart';
import 'package:cielo_estrellado/models/onboarding_page.dart';
import 'package:cielo_estrellado/presentation/screen/home/home_screen.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;
  late Animation<double> _skyAnimation;
  int _currentPage = 0;
  late List<OnboardingPage> _pages;
  late AnimationController _skyController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Continuous twinkle animation
    _skyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    _skyAnimation = Tween<double>(begin: 0, end: 1).animate(_skyController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final l10n = AppLocalizations.of(context)!;
      _pages = OnboardingPage.getPages(l10n);
      
      // Initialize animation controllers for each page
      _animationControllers = List.generate(
        _pages.length,
        (index) => AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 600),
        ),
      );
      
      _animations = _animationControllers.map((controller) {
        return CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );
      }).toList();

      // Start first page animation
      _animationControllers[0].forward();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _skyController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    
    // Animate the new page
    if (page < _animationControllers.length) {
      _animationControllers[page].forward();
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await OnboardingStorage.setOnboardingCompleted();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background stars effect
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _skyAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: NightSkyPainter(
                      seed: 42,
                      starCount: 800,
                      baseStars: 500,
                      twinkleValue: _skyAnimation.value,
                    ),
                  );
                },
              ),
            ),
            
            // Page view
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return OnboardingPageWidget(
                  page: _pages[index],
                  animation: _animations[index],
                );
              },
            ),
            
            // Skip button
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: 16,
                right: 16,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: Text(
                    AppLocalizations.of(context)!.onboardingSkip,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            
            // Bottom controls
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildPageIndicator(index),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Next/Start button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pages[_currentPage].accentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: _pages[_currentPage].accentColor.withOpacity(0.5),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1 
                              ? AppLocalizations.of(context)!.onboardingStart 
                              : AppLocalizations.of(context)!.onboardingNext,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    final isActive = index == _currentPage;
    final color = isActive 
        ? _pages[_currentPage].accentColor 
        : Colors.white24;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }
}

