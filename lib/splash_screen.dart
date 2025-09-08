import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppob_app/features/auth/presentation/pages/login_page.dart';
import 'package:ppob_app/features/onboarding/presentation/pages/onboarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _forceLoginEveryLaunch();
  }

  Future<void> _forceLoginEveryLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    // Hapus token setiap kali app dibuka
    await prefs.remove("auth_token");

    // Cek apakah user sudah pernah melihat onboarding
    final seenOnboarding = prefs.getBool("seen_onboarding") ?? false;

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
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}