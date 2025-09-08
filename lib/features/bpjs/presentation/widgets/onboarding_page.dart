import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback? onSkipPressed;
  final bool showSkip;

  // Style parameters
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final double? subtitleFontSize;
  final FontWeight? subtitleFontWeight;
  final Color? subtitleColor;
  final Widget? pageIndicator;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    this.onSkipPressed,
    this.showSkip = true,
    this.titleFontSize = 24,
    this.titleFontWeight = FontWeight.w700,
    this.titleColor = const Color(0xFF5938FB),
    this.subtitleFontSize = 16,
    this.subtitleFontWeight = FontWeight.w400,
    this.subtitleColor = const Color(0xFF6B7280),
    this.pageIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Skip button
              if (showSkip)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: onSkipPressed,
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 40),

              // Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 40),

              // Content
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: titleFontWeight,
                        color: titleColor,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        fontWeight: subtitleFontWeight,
                        color: subtitleColor,
                        fontFamily: 'Poppins',
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // Page Indicator (jika ada)
                    if (pageIndicator != null) ...[
                      pageIndicator!,
                      const SizedBox(height: 20),
                    ],

                    // Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5938FB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
