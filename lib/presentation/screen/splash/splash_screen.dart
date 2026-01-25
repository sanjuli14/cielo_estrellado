import 'package:cielo_estrellado/features/sky/sky_painter.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:cielo_estrellado/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _skyAnimation;
  late Animation<double> _text1Opacity;
  late Animation<Offset> _text1Slide;
  late Animation<double> _text2Opacity;
  late Animation<Offset> _text2Slide;
  late Animation<double> _logoOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    _skyAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _text1Opacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
    );

    _text1Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
    ));

    _text2Opacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeIn),
    );

    _text2Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeOut),
    ));

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 0.9, curve: Curves.easeIn),
    );

    _controller.forward().then((_) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _skyAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: NightSkyPainter(
                    seed: 42,
                    progress: _skyAnimation.value,
                    twinkleValue: 0,
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom:20 ,
            left: 70,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Copyright (c) 2026. Todos los derechos reservados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.025, // Responsive font size
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          
          // Foreground Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _text1Opacity,
                    child: SlideTransition(
                      position: _text1Slide,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppLocalizations.of(context)!.splashEveryMinute,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.06, // Responsive font size
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 16),
                  FadeTransition(
                    opacity: _text2Opacity,
                    child: SlideTransition(
                      position: _text2Slide,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppLocalizations.of(context)!.splashEveryStar,
                          style: TextStyle(
                            color: const Color(0xFFFFD1A4),
                            fontSize: screenWidth * 0.08, // Responsive font size
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 32 : 48),
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/icono.svg',
                          width: screenWidth * 0.3, // Responsive logo size
                          height: screenWidth * 0.3,
                        ),
                        const SizedBox(height: 16),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'FOCUS NIGHT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045, // Responsive font size
                              fontWeight: FontWeight.w600,
                              letterSpacing: 4.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 32 : 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
