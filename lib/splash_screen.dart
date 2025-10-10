import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppob_app/features/auth/presentation/pages/login_page.dart';
import 'package:ppob_app/features/onboarding/presentation/pages/onboarding_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _colorController;
  late AnimationController _textController;

  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _textOpacity;
  late Animation<Color?> _logoColorAnimation;

  // Define custom purple color
  final Color customPurple = const Color(0xFF5938FB);

  @override
  void initState() {
    super.initState();

    // 1. Logo fade in + scale in
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _scaleAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack);

    // 2. Background color transition (putih → ungu custom)
    _colorController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: customPurple, // Menggunakan custom purple
    ).animate(CurvedAnimation(parent: _colorController, curve: Curves.easeIn));

    // 3. Logo color transition (ungu custom → putih)
    _logoColorAnimation = ColorTween(
      begin: customPurple, // Menggunakan custom purple
      end: Colors.white,
    ).animate(CurvedAnimation(parent: _colorController, curve: Curves.easeIn));

    // 4. Text fade in
    _textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _textOpacity =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);

    _startSequence();
  }

  Future<void> _startSequence() async {
    await _logoController.forward();
    await _colorController.forward();
    await _textController.forward();
    _forceLoginEveryLaunch();
  }

  Future<void> _forceLoginEveryLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
    final seenOnboarding = prefs.getBool("seen_onboarding") ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      if (seenOnboarding) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreens()),
        );
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _colorController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([_scaleAnimation, _logoColorAnimation]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          "assets/images/iconmodipaysplash.png",
                          color: _logoColorAnimation.value,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _textOpacity,
                  child: Column(
                    children: [
                      Text(
                        "PPOB Merah Putih",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _colorAnimation.value == Colors.white 
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Satu Pintu Semua Pembayaran",
                        style: TextStyle(
                          fontSize: 16,
                          color: _colorAnimation.value == Colors.white 
                              ? Colors.black87
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}