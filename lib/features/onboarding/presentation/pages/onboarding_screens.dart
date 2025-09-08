import 'package:flutter/material.dart';
import 'package:ppob_app/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:ppob_app/features/onboarding/presentation/pages/onboarding_string.dart';
import 'package:ppob_app/features/auth/presentation/pages/welcome_page.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToWelcome();
    }
  }

  void _goToWelcome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Page 1
                OnboardingPage(
                  imagePath: 'assets/images/onboarding1.png',
                  title: 'Harga Paling Terjangkau',
                  subtitle:
                      'Nikmati kemudahan beli pulsa, top up game bayar listrik, air, internet, dan layanan digital lainnya dengan harga ramah di kantong. Banyak promo menarik setiap hari untuk transaksi lebih hemat!',
                  buttonText: OnboardingStrings.next,
                  onButtonPressed: _nextPage,
                  onSkipPressed: _goToWelcome,
                  titleFontSize: 23,
                  titleFontWeight: FontWeight.w700,
                  titleColor: const Color(0xFF5938FB),
                  subtitleFontSize: 15,
                  subtitleFontWeight: FontWeight.w500,
                  subtitleColor: const Color.fromARGB(255, 0, 0, 0),
                ),

                // Page 2
                OnboardingPage(
                  imagePath: 'assets/images/onboarding2.png',
                  title: OnboardingStrings.onboarding2Title,
                  subtitle: OnboardingStrings.onboarding2Subtitle,
                  buttonText: OnboardingStrings.next,
                  onButtonPressed: _nextPage,
                  onSkipPressed: _goToWelcome,
                  titleFontSize: 23,
                  titleFontWeight: FontWeight.w700,
                  titleColor: const Color(0xFF5938FB),
                  subtitleFontSize: 16,
                  subtitleFontWeight: FontWeight.w500,
                  subtitleColor: const Color.fromARGB(255, 0, 0, 0),
                ),

                // Page 3
                OnboardingPage(
                  imagePath: 'assets/images/onboarding3.png',
                  title: OnboardingStrings.onboarding3Title,
                  subtitle: OnboardingStrings.onboarding3Subtitle,
                  buttonText: OnboardingStrings.registerNow,
                  onButtonPressed: _goToWelcome,
                  showSkip: false, // Tidak ada skip di halaman terakhir
                  titleFontSize: 23,
                  titleFontWeight: FontWeight.w700,
                  titleColor: const Color(0xFF5938FB),
                  subtitleFontSize: 16,
                  subtitleFontWeight: FontWeight.w500,
                  subtitleColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),

          // Page indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF5938FB)
                        : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
