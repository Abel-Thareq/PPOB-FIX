import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/shared/constants/app_constants.dart';
import 'package:ppob_app/features/auth/presentation/pages/login_page.dart';
import 'package:ppob_app/features/auth/presentation/pages/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Style untuk button text
    final buttonTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      fontFamily: 'Poppins',
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(color: Colors.white),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/welcome_page.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Text(
                AppStrings.welcomeSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF5938FB),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Welcome Text
              Text(
                AppStrings.welcome,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Buttons
              CustomButton(
                text: AppStrings.createAccount,
                textStyle: buttonTextStyle,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              CustomButton(
                text: AppStrings.alreadyHaveAccount,
                isOutlined: true,
                textStyle: buttonTextStyle,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
